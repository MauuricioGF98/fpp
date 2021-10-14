#include <linux/bpf.h>
#include <linux/if_ether.h>
#include <linux/ip.h>
#include <linux/tcp.h>
#include <linux/udp.h>
#include <linux/in.h>
#include <linux/pkt_cls.h>
#include <linux/version.h>
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_endian.h>


#ifndef __section
# define __section(NAME)                  \
   __attribute__((section(NAME), used))
#endif

#ifndef __inline
# define __inline                         \
        inline __attribute__((always_inline))
#endif

#ifndef lock_xadd
# define lock_xadd(ptr, val)              \
        ((void)__sync_fetch_and_add(ptr, val))
#endif
/*
#ifndef BPF_FUNC
# define BPF_FUNC(NAME, ...)              \
   (*NAME)(__VA_ARGS__) = (void *)BPF_FUNC_##NAME
#endif
*/

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


__section("egress")
int profiling_protocol(struct __sk_buff *skb) {

    void* data_end = (void*)(long)skb->data_end;
    void* data = (void*)(long)skb->data;
    struct ethhdr *eth = data;

	if (eth + 1 > data_end)
		return TC_ACT_OK;

	struct ptp_data *ptp = (void*) eth + sizeof(*eth);

	if (ptp + 1 > data_end)
		return TC_ACT_OK;
		
	struct fpp_management *fpp_man = (void*) ptp + sizeof(*ptp);

	if (fpp_man + 1 > data_end)
			return TC_ACT_OK;
	
	//if (fpp_man->fpp_prefix == bpf_htonl(0xf99fef15)) {
	struct node_management *node_man = (void*) fpp_man + sizeof(*fpp_man);

	if (node_man + 1 > data_end)
		return TC_ACT_OK;
		
	node_man->timestamp_egress = bpf_htonl(bpf_ktime_get_ns());
	
	return TC_ACT_OK;
}
 
char __license[] __section("license") = "GPL";
