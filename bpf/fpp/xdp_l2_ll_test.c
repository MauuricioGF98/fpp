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
	__u8 node_id[7];
	__u64 timestamp_ingress;
	__u64 timestamp_egress;
};

struct ptp_data {
	__u8 data[45];
};


#define PRO_MAN_SIZE sizeof(struct fpp_management)
#define NODE_MAN_SIZE sizeof(struct node_management)
#define NODES_TO_STORE 10


int profiling_protocol(struct xdp_md *ctx) {
	
	void *data = (void *)(long)ctx->data;
	void *data_end = (void *)(long)ctx->data_end;

//	if (bpf_xdp_adjust_tail(ctx, (int)(PRO_MAN_SIZE + NODE_MAN_SIZE * NODES_TO_STORE)))
//			return XDP_PASS;

	//Reevaluate the data_end, data pointers and do bound checks again after the adjustament
//	data = (void *)(long)ctx->data;
//	data_end = (void *)(long)ctx->data_end;

	struct ethhdr *eth = data;

	if (eth + 1 > data_end)
		return XDP_PASS;

/*
	if (bpf_xdp_adjust_tail(ctx, (int)(PRO_MAN_SIZE + NODE_MAN_SIZE * NODES_TO_STORE)))
			return XDP_PASS;

		Reevaluate the data_end, data pointers and do bound checks again after the adjustament
		data = (void *)(long)ctx->data;
		data_end = (void *)(long)ctx->data_end;

		eth = data;

		if (eth + 1 > data_end)
			return XDP_PASS;
*/
		struct ptp_data *ptp = (void*) eth + sizeof(*eth);

		if (ptp + 1 > data_end)
			return XDP_PASS;
		
		struct fpp_management *fpp_man = (void*) ptp + sizeof(*ptp);

		if (fpp_man + 1 > data_end)
			return XDP_PASS;

		fpp_man->fpp_prefix = bpf_htonl(0xf99fef15);
		fpp_man->node_offset = bpf_htons(0x0001);
		fpp_man->packet_size = bpf_htons(0x0022);
		struct node_management *node_man = (void*) fpp_man + sizeof(*fpp_man);

		if (node_man + 1 > data_end)
			return XDP_PASS;
		
		strcpy(node_man->node_id, "AAAAAAA");
		node_man->timestamp_ingress = bpf_ktime_get_ns();
		node_man->timestamp_egress = 0x0000000000000000;
	
		return XDP_PASS;
}

char _license[] SEC("license") = "GPL";
