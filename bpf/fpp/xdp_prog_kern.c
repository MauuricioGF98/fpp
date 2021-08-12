#include <stddef.h>
#include <linux/bpf.h>
#include <linux/in.h>
#include <linux/if_ether.h>
#include <linux/if_packet.h>
#include <linux/ipv6.h>
#include <linux/icmpv6.h>
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_endian.h>
#include <linux/udp.h>
#include <linux/ip.h>
#include <string.h>

struct protocol_management {
	__u32 fpp_prefix;
	__u16 node_offset;
	__be16 packet_size;
};
struct node_management {
	__u8 interface_id[7];
	__u64 timestamp_ingress;
	__u64 timestamp_egress;
};

int profiling_protocol(struct xdp_md *ctx) {
	
	void *data = (void *)(long)ctx->data;
	void *data_end = (void *)(long)ctx->data_end;
	struct ethhdr *eth = data;

	if (eth + 1 > data_end)
		return XDP_ABORTED;

	struct iphdr *ip = (void*)eth + sizeof(*eth);

	if (ip + 1 > data_end) 
		return XDP_ABORTED;

	int hdrsize = ip->ihl * 4;

	if (hdrsize < sizeof(*ip) || (void*) ip + hdrsize > data_end)
		return XDP_ABORTED;
 
	struct udphdr *udph = (void*) ip + hdrsize;

	if (udph + 1 > data_end) 
		return XDP_ABORTED;

	struct protocol_management *protocol_man = (void*) udph + sizeof(*udph);

	if( protocol_man + 1 > data_end) 
		return XDP_ABORTED;

	if (protocol_man->fpp_prefix == 0xf99fef15) {
		int offset = bpf_ntohs(protocol_man->node_offset);
		int bytes_to_shift = offset * sizeof(struct node_management);
		bytes_to_shift += sizeof(*protocol_man);
		offset += 1;
		protocol_man->node_offset = bpf_htons(offset);

		if (bytes_to_shift >= 500)
			return XDP_ABORTED;

		struct node_management *node_man = (void*) protocol_man + bytes_to_shift;
		if (node_man + 1 > data_end) 
			return XDP_ABORTED;

		//strcpy(node_man->interface_id, eth->h_dest);
		node_man->timestamp_ingress = bpf_ktime_get_ns();
		node_man->timestamp_egress = 0x0000000000000000;
	} else {
		protocol_man->fpp_prefix = 0xf99fef15;
		protocol_man->node_offset = bpf_htons(0x0001);
		protocol_man->packet_size = ip->tot_len;
		struct node_management *node_man = (void*) protocol_man + sizeof(*protocol_man);

		if (node_man + 1 > data_end)
			return XDP_ABORTED;
		
		//node_man->interface_id = ip->daddr;
		node_man->timestamp_ingress = bpf_ktime_get_ns();
		node_man->timestamp_egress = 0x0000000000000000;
	}	
	return XDP_PASS;
}

char _license[] SEC("license") = "GPL";
