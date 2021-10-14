#!/usr/bin/env python3

from bcc import BPF
from pyroute2 import IPRoute

ipr = IPRoute()

bpf = BPF(src_file="tc_fpp.c", debug=0)
fn = bpf.load_func("profiling_protocol", BPF.SCHED_CLS)
idx = ipr.link_lookup(ifname="lo")[0]
ipr.tc("add", "clsact", idx)

ipr.tc("add-filter", "bpf", idx, ":1", fd=fn.fd, name=fn.name, parent="ffff:fff3", direct_action=True)