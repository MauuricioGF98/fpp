#include <stddef.h>
#include <linux/bpf.h>
#include <linux/in.h>
#include <linux/if_ether.h>
#include <linux/if_packet.h>
#include <bpf/bpf_endian.h>
#include <linux/ip.h>
#include <string.h>
#include <bpf/bpf_helpers.h>

struct fpp_management {
	__u32 fpp_prefix;
	__u16 node_offset;
	__be16 packet_size;
};
struct node_management {
	__u8 interface_id[7];
	__u64 timestamp_ingress;
	__u64 timestamp_egress;
};

#define PRO_MAN_SIZE sizeof(struct fpp_management)
#define NODE_MAN_SIZE sizeof(struct node_management)
#define NODES_TO_STORE 10


int profiling_protocol(struct xdp_md *ctx) {
	
	void *data = (void *)(long)ctx->data;
	void *data_end = (void *)(long)ctx->data_end;

	struct ethhdr *eth = data;

	if (eth + 1 > data_end)
		return XDP_PASS;

	struct iphdr *ip = (void*)eth + sizeof(*eth);

	if (ip + 1 > data_end) 
		return XDP_PASS;

	int ip_length = bpf_ntohs(ip->tot_len);

	if (ip_length > 1500 || (void*) ip + ip_length > data_end)
		return XDP_PASS;
 
	struct fpp_management *fpp_man = (void*) ip + ip_length;

	/* If it is the first node visited and there is no fpp_management structure stored in
	 the packet yet, the bound check will fail (FCS is smaller than the 8 Bytes fpp_management struct) 
	 */
	if (fpp_man + 1 > data_end) {

		/*Check if there is enough space to store the selected number of NODES_TO_STORE*/
		if (ip_length + (int)(PRO_MAN_SIZE + NODE_MAN_SIZE * NODES_TO_STORE) > 1500)
			return XDP_PASS;
			
		/* Add space at the end of the frame to store a protocol management struct
	 	* and five node management structures
	 	*/
		if (bpf_xdp_adjust_tail(ctx, (int)(PRO_MAN_SIZE + NODE_MAN_SIZE * NODES_TO_STORE)))
			return XDP_PASS;

		/* Reevaluate the data_end, data pointers and do bound checks again after the adjustament*/
		data = (void *)(long)ctx->data;
		data_end = (void *)(long)ctx->data_end;

		eth = data;

		if (eth + 1 > data_end)
			return XDP_PASS;

		ip = (void*)eth + sizeof(*eth);

		if (ip + 1 > data_end) 
			return XDP_PASS;

		if (ip_length > 1500 - (int)(PRO_MAN_SIZE + NODE_MAN_SIZE * NODES_TO_STORE) || (void*) ip + ip_length > data_end)
			return XDP_PASS;
 
		fpp_man = (void*) ip + ip_length;

		if (fpp_man + 1 > data_end)
			return XDP_PASS;

		fpp_man->fpp_prefix = bpf_htonl(0xf99fef15);
		fpp_man->node_offset = bpf_htons(0x0001);
		fpp_man->packet_size = ip->tot_len;
		struct node_management *node_man = (void*) fpp_man + sizeof(*fpp_man);

		if (node_man + 1 > data_end)
			return XDP_PASS;
		
		strcpy(node_man->interface_id, "AAAAAAA");
		node_man->timestamp_ingress = bpf_ktime_get_ns();
		node_man->timestamp_egress = 0x0000000000000000;
	} else { 
		if (fpp_man->fpp_prefix == bpf_ntohl(0xf99ffe15)) {
			int offset = bpf_ntohs(fpp_man->node_offset);
			int bytes_to_shift = offset * sizeof(struct node_management);
			bytes_to_shift += sizeof(*fpp_man);
			offset += 1;
			fpp_man->node_offset = bpf_htons(offset);

			/* bytes_to_shift bounded to 1454 - 24 bytes, which is the most we can shift with a minimal IP payload of 46 Bytes
			 to store a 24 Byte data of a new node. 
			*/
			if (bytes_to_shift > 1454 - 24)
				return XDP_PASS;

			struct node_management *node_man = (void*) fpp_man + bytes_to_shift;
			if (node_man + 1 > data_end) 
				return XDP_PASS;

			strcpy(node_man->interface_id, "AAAAAAA");
			node_man->timestamp_ingress = bpf_ktime_get_ns();
			node_man->timestamp_egress = 0x0000000000000000;
		} else {
			return XDP_PASS;
		}
	}	
	return XDP_PASS;
}

char _license[] SEC("license") = "GPL";
