; ModuleID = 'xdp_prog_kern.c'
source_filename = "xdp_prog_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

%struct.xdp_md = type { i32, i32, i32, i32, i32 }
%struct.ethhdr = type { [6 x i8], [6 x i8], i16 }
%struct.iphdr = type { i8, i8, i16, i16, i16, i8, i8, i16, i32, i32 }
%struct.udphdr = type { i16, i16, i16, i16 }
%struct.protocol_management = type { i32, i16, i16 }
%struct.node_management = type { [7 x i8], i64, i64 }

@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !0
@llvm.used = appending global [1 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @profiling_protocol(%struct.xdp_md* nocapture readonly %0) local_unnamed_addr #0 !dbg !37 {
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !51, metadata !DIExpression()), !dbg !120
  %2 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !121
  %3 = load i32, i32* %2, align 4, !dbg !121, !tbaa !122
  %4 = zext i32 %3 to i64, !dbg !127
  call void @llvm.dbg.value(metadata i64 %4, metadata !52, metadata !DIExpression()), !dbg !120
  %5 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !128
  %6 = load i32, i32* %5, align 4, !dbg !128, !tbaa !129
  %7 = zext i32 %6 to i64, !dbg !130
  %8 = inttoptr i64 %7 to i8*, !dbg !131
  call void @llvm.dbg.value(metadata i8* %8, metadata !53, metadata !DIExpression()), !dbg !120
  %9 = inttoptr i64 %4 to %struct.ethhdr*, !dbg !132
  call void @llvm.dbg.value(metadata %struct.ethhdr* %9, metadata !54, metadata !DIExpression()), !dbg !120
  %10 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %9, i64 1, !dbg !133
  %11 = inttoptr i64 %7 to %struct.ethhdr*, !dbg !135
  %12 = icmp ugt %struct.ethhdr* %10, %11, !dbg !136
  br i1 %12, label %87, label %13, !dbg !137

13:                                               ; preds = %1
  %14 = inttoptr i64 %4 to i8*, !dbg !138
  call void @llvm.dbg.value(metadata i8* %14, metadata !52, metadata !DIExpression()), !dbg !120
  %15 = getelementptr i8, i8* %14, i64 14, !dbg !139
  call void @llvm.dbg.value(metadata i8* %15, metadata !68, metadata !DIExpression()), !dbg !120
  %16 = getelementptr i8, i8* %14, i64 34, !dbg !140
  %17 = bitcast i8* %16 to %struct.iphdr*, !dbg !140
  %18 = inttoptr i64 %7 to %struct.iphdr*, !dbg !142
  %19 = icmp ugt %struct.iphdr* %17, %18, !dbg !143
  br i1 %19, label %87, label %20, !dbg !144

20:                                               ; preds = %13
  %21 = load i8, i8* %15, align 4, !dbg !145
  %22 = shl i8 %21, 2, !dbg !146
  %23 = and i8 %22, 60, !dbg !146
  call void @llvm.dbg.value(metadata i8 %23, metadata !87, metadata !DIExpression(DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !120
  %24 = icmp ult i8 %23, 20, !dbg !147
  br i1 %24, label %87, label %25, !dbg !149

25:                                               ; preds = %20
  %26 = zext i8 %23 to i64
  call void @llvm.dbg.value(metadata i64 %26, metadata !87, metadata !DIExpression()), !dbg !120
  %27 = getelementptr i8, i8* %15, i64 %26, !dbg !150
  %28 = icmp ugt i8* %27, %8, !dbg !151
  br i1 %28, label %87, label %29, !dbg !152

29:                                               ; preds = %25
  call void @llvm.dbg.value(metadata i8* %27, metadata !88, metadata !DIExpression()), !dbg !120
  %30 = getelementptr i8, i8* %27, i64 8, !dbg !153
  %31 = bitcast i8* %30 to %struct.udphdr*, !dbg !153
  %32 = inttoptr i64 %7 to %struct.udphdr*, !dbg !155
  %33 = icmp ugt %struct.udphdr* %31, %32, !dbg !156
  br i1 %33, label %87, label %34, !dbg !157

34:                                               ; preds = %29
  call void @llvm.dbg.value(metadata i8* %30, metadata !97, metadata !DIExpression()), !dbg !120
  %35 = getelementptr i8, i8* %30, i64 8, !dbg !158
  %36 = bitcast i8* %35 to %struct.protocol_management*, !dbg !158
  %37 = inttoptr i64 %7 to %struct.protocol_management*, !dbg !160
  %38 = icmp ugt %struct.protocol_management* %36, %37, !dbg !161
  br i1 %38, label %87, label %39, !dbg !162

39:                                               ; preds = %34
  %40 = bitcast i8* %30 to i32*, !dbg !163
  %41 = load i32, i32* %40, align 4, !dbg !163, !tbaa !164
  %42 = icmp eq i32 %41, -106959083, !dbg !167
  br i1 %42, label %43, label %68, !dbg !168

43:                                               ; preds = %39
  %44 = getelementptr inbounds i8, i8* %30, i64 4, !dbg !169
  %45 = bitcast i8* %44 to i16*, !dbg !169
  %46 = load i16, i16* %45, align 4, !dbg !169, !tbaa !170
  %47 = tail call i16 @llvm.bswap.i16(i16 %46)
  %48 = zext i16 %47 to i32, !dbg !169
  call void @llvm.dbg.value(metadata i32 %48, metadata !104, metadata !DIExpression()), !dbg !171
  %49 = mul nuw nsw i32 %48, 24, !dbg !172
  call void @llvm.dbg.value(metadata i16 %47, metadata !107, metadata !DIExpression(DW_OP_LLVM_convert, 16, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_constu, 24, DW_OP_mul, DW_OP_stack_value)), !dbg !171
  call void @llvm.dbg.value(metadata i32 %49, metadata !107, metadata !DIExpression(DW_OP_plus_uconst, 8, DW_OP_stack_value)), !dbg !171
  %50 = add i16 %47, 1, !dbg !173
  call void @llvm.dbg.value(metadata i32 %48, metadata !104, metadata !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value)), !dbg !171
  %51 = tail call i16 @llvm.bswap.i16(i16 %50), !dbg !174
  store i16 %51, i16* %45, align 4, !dbg !175, !tbaa !170
  %52 = icmp ugt i32 %49, 491, !dbg !176
  br i1 %52, label %87, label %53, !dbg !178

53:                                               ; preds = %43
  %54 = add nuw nsw i32 %49, 8, !dbg !179
  call void @llvm.dbg.value(metadata i32 %54, metadata !107, metadata !DIExpression()), !dbg !171
  %55 = zext i32 %54 to i64, !dbg !180
  %56 = getelementptr i8, i8* %30, i64 %55, !dbg !180
  call void @llvm.dbg.value(metadata i8* %56, metadata !108, metadata !DIExpression()), !dbg !171
  %57 = getelementptr inbounds i8, i8* %56, i64 24, !dbg !181
  %58 = bitcast i8* %57 to %struct.node_management*, !dbg !181
  %59 = inttoptr i64 %7 to %struct.node_management*, !dbg !183
  %60 = icmp ugt %struct.node_management* %58, %59, !dbg !184
  br i1 %60, label %87, label %61, !dbg !185

61:                                               ; preds = %53
  call void @llvm.dbg.value(metadata i8* %56, metadata !108, metadata !DIExpression()), !dbg !171
  %62 = bitcast i8* %56 to i64*, !dbg !186
  store i64 18367622009667905, i64* %62, align 1, !dbg !186
  %63 = tail call i64 inttoptr (i64 5 to i64 ()*)() #2, !dbg !187
  %64 = getelementptr inbounds i8, i8* %56, i64 8, !dbg !188
  %65 = bitcast i8* %64 to i64*, !dbg !188
  store i64 %63, i64* %65, align 8, !dbg !189, !tbaa !190
  %66 = getelementptr inbounds i8, i8* %56, i64 16, !dbg !193
  %67 = bitcast i8* %66 to i64*, !dbg !193
  store i64 0, i64* %67, align 8, !dbg !194, !tbaa !195
  br label %87

68:                                               ; preds = %39
  store i32 -106959083, i32* %40, align 4, !dbg !196, !tbaa !164
  %69 = getelementptr inbounds i8, i8* %30, i64 4, !dbg !197
  %70 = bitcast i8* %69 to i16*, !dbg !197
  store i16 256, i16* %70, align 4, !dbg !198, !tbaa !170
  %71 = getelementptr i8, i8* %14, i64 16, !dbg !199
  %72 = bitcast i8* %71 to i16*, !dbg !199
  %73 = load i16, i16* %72, align 2, !dbg !199, !tbaa !200
  %74 = getelementptr inbounds i8, i8* %30, i64 6, !dbg !202
  %75 = bitcast i8* %74 to i16*, !dbg !202
  store i16 %73, i16* %75, align 2, !dbg !203, !tbaa !204
  call void @llvm.dbg.value(metadata i8* %35, metadata !118, metadata !DIExpression()), !dbg !205
  %76 = getelementptr inbounds i8, i8* %35, i64 24, !dbg !206
  %77 = bitcast i8* %76 to %struct.node_management*, !dbg !206
  %78 = inttoptr i64 %7 to %struct.node_management*, !dbg !208
  %79 = icmp ugt %struct.node_management* %77, %78, !dbg !209
  br i1 %79, label %87, label %80, !dbg !210

80:                                               ; preds = %68
  call void @llvm.dbg.value(metadata i8* %35, metadata !118, metadata !DIExpression()), !dbg !205
  %81 = bitcast i8* %35 to i64*, !dbg !211
  store i64 18367622009667905, i64* %81, align 1, !dbg !211
  %82 = tail call i64 inttoptr (i64 5 to i64 ()*)() #2, !dbg !212
  %83 = getelementptr inbounds i8, i8* %35, i64 8, !dbg !213
  %84 = bitcast i8* %83 to i64*, !dbg !213
  store i64 %82, i64* %84, align 8, !dbg !214, !tbaa !190
  %85 = getelementptr inbounds i8, i8* %35, i64 16, !dbg !215
  %86 = bitcast i8* %85 to i64*, !dbg !215
  store i64 0, i64* %86, align 8, !dbg !216, !tbaa !195
  br label %87

87:                                               ; preds = %53, %43, %80, %61, %13, %29, %68, %34, %20, %25, %1
  %88 = phi i32 [ 0, %1 ], [ 0, %13 ], [ 0, %25 ], [ 0, %20 ], [ 0, %29 ], [ 0, %34 ], [ 0, %68 ], [ 2, %61 ], [ 2, %80 ], [ 0, %43 ], [ 0, %53 ], !dbg !120
  ret i32 %88, !dbg !217
}

; Function Attrs: nounwind readnone speculatable willreturn
declare i16 @llvm.bswap.i16(i16) #1

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!33, !34, !35}
!llvm.ident = !{!36}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 87, type: !29, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "Debian clang version 11.0.1-2", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !14, globals: !20, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "xdp_prog_kern.c", directory: "/root/ba-garrido/code/bpf/fpp")
!4 = !{!5}
!5 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "xdp_action", file: !6, line: 2845, baseType: !7, size: 32, elements: !8)
!6 = !DIFile(filename: "../headers/linux/bpf.h", directory: "/root/ba-garrido/code/bpf/fpp")
!7 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!8 = !{!9, !10, !11, !12, !13}
!9 = !DIEnumerator(name: "XDP_ABORTED", value: 0, isUnsigned: true)
!10 = !DIEnumerator(name: "XDP_DROP", value: 1, isUnsigned: true)
!11 = !DIEnumerator(name: "XDP_PASS", value: 2, isUnsigned: true)
!12 = !DIEnumerator(name: "XDP_TX", value: 3, isUnsigned: true)
!13 = !DIEnumerator(name: "XDP_REDIRECT", value: 4, isUnsigned: true)
!14 = !{!15, !16, !17}
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!16 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!17 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u16", file: !18, line: 24, baseType: !19)
!18 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "")
!19 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!20 = !{!0, !21}
!21 = !DIGlobalVariableExpression(var: !22, expr: !DIExpression())
!22 = distinct !DIGlobalVariable(name: "bpf_ktime_get_ns", scope: !2, file: !23, line: 89, type: !24, isLocal: true, isDefinition: true)
!23 = !DIFile(filename: "../libbpf/src//build/usr/include/bpf/bpf_helper_defs.h", directory: "/root/ba-garrido/code/bpf/fpp")
!24 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !25, size: 64)
!25 = !DISubroutineType(types: !26)
!26 = !{!27}
!27 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !18, line: 31, baseType: !28)
!28 = !DIBasicType(name: "long long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!29 = !DICompositeType(tag: DW_TAG_array_type, baseType: !30, size: 32, elements: !31)
!30 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!31 = !{!32}
!32 = !DISubrange(count: 4)
!33 = !{i32 7, !"Dwarf Version", i32 4}
!34 = !{i32 2, !"Debug Info Version", i32 3}
!35 = !{i32 1, !"wchar_size", i32 4}
!36 = !{!"Debian clang version 11.0.1-2"}
!37 = distinct !DISubprogram(name: "profiling_protocol", scope: !3, file: !3, line: 25, type: !38, scopeLine: 25, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !50)
!38 = !DISubroutineType(types: !39)
!39 = !{!40, !41}
!40 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!41 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !42, size: 64)
!42 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 2856, size: 160, elements: !43)
!43 = !{!44, !46, !47, !48, !49}
!44 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !42, file: !6, line: 2857, baseType: !45, size: 32)
!45 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !18, line: 27, baseType: !7)
!46 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !42, file: !6, line: 2858, baseType: !45, size: 32, offset: 32)
!47 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !42, file: !6, line: 2859, baseType: !45, size: 32, offset: 64)
!48 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !42, file: !6, line: 2861, baseType: !45, size: 32, offset: 96)
!49 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !42, file: !6, line: 2862, baseType: !45, size: 32, offset: 128)
!50 = !{!51, !52, !53, !54, !68, !87, !88, !97, !104, !107, !108, !118}
!51 = !DILocalVariable(name: "ctx", arg: 1, scope: !37, file: !3, line: 25, type: !41)
!52 = !DILocalVariable(name: "data", scope: !37, file: !3, line: 27, type: !15)
!53 = !DILocalVariable(name: "data_end", scope: !37, file: !3, line: 28, type: !15)
!54 = !DILocalVariable(name: "eth", scope: !37, file: !3, line: 29, type: !55)
!55 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !56, size: 64)
!56 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ethhdr", file: !57, line: 164, size: 112, elements: !58)
!57 = !DIFile(filename: "/usr/include/linux/if_ether.h", directory: "")
!58 = !{!59, !64, !65}
!59 = !DIDerivedType(tag: DW_TAG_member, name: "h_dest", scope: !56, file: !57, line: 165, baseType: !60, size: 48)
!60 = !DICompositeType(tag: DW_TAG_array_type, baseType: !61, size: 48, elements: !62)
!61 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!62 = !{!63}
!63 = !DISubrange(count: 6)
!64 = !DIDerivedType(tag: DW_TAG_member, name: "h_source", scope: !56, file: !57, line: 166, baseType: !60, size: 48, offset: 48)
!65 = !DIDerivedType(tag: DW_TAG_member, name: "h_proto", scope: !56, file: !57, line: 167, baseType: !66, size: 16, offset: 96)
!66 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !67, line: 25, baseType: !17)
!67 = !DIFile(filename: "/usr/include/linux/types.h", directory: "")
!68 = !DILocalVariable(name: "ip", scope: !37, file: !3, line: 34, type: !69)
!69 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !70, size: 64)
!70 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iphdr", file: !71, line: 86, size: 160, elements: !72)
!71 = !DIFile(filename: "/usr/include/linux/ip.h", directory: "")
!72 = !{!73, !75, !76, !77, !78, !79, !80, !81, !82, !84, !86}
!73 = !DIDerivedType(tag: DW_TAG_member, name: "ihl", scope: !70, file: !71, line: 88, baseType: !74, size: 4, flags: DIFlagBitField, extraData: i64 0)
!74 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u8", file: !18, line: 21, baseType: !61)
!75 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !70, file: !71, line: 89, baseType: !74, size: 4, offset: 4, flags: DIFlagBitField, extraData: i64 0)
!76 = !DIDerivedType(tag: DW_TAG_member, name: "tos", scope: !70, file: !71, line: 96, baseType: !74, size: 8, offset: 8)
!77 = !DIDerivedType(tag: DW_TAG_member, name: "tot_len", scope: !70, file: !71, line: 97, baseType: !66, size: 16, offset: 16)
!78 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !70, file: !71, line: 98, baseType: !66, size: 16, offset: 32)
!79 = !DIDerivedType(tag: DW_TAG_member, name: "frag_off", scope: !70, file: !71, line: 99, baseType: !66, size: 16, offset: 48)
!80 = !DIDerivedType(tag: DW_TAG_member, name: "ttl", scope: !70, file: !71, line: 100, baseType: !74, size: 8, offset: 64)
!81 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !70, file: !71, line: 101, baseType: !74, size: 8, offset: 72)
!82 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !70, file: !71, line: 102, baseType: !83, size: 16, offset: 80)
!83 = !DIDerivedType(tag: DW_TAG_typedef, name: "__sum16", file: !67, line: 31, baseType: !17)
!84 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !70, file: !71, line: 103, baseType: !85, size: 32, offset: 96)
!85 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be32", file: !67, line: 27, baseType: !45)
!86 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !70, file: !71, line: 104, baseType: !85, size: 32, offset: 128)
!87 = !DILocalVariable(name: "hdrsize", scope: !37, file: !3, line: 39, type: !40)
!88 = !DILocalVariable(name: "udph", scope: !37, file: !3, line: 44, type: !89)
!89 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !90, size: 64)
!90 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "udphdr", file: !91, line: 23, size: 64, elements: !92)
!91 = !DIFile(filename: "/usr/include/linux/udp.h", directory: "")
!92 = !{!93, !94, !95, !96}
!93 = !DIDerivedType(tag: DW_TAG_member, name: "source", scope: !90, file: !91, line: 24, baseType: !66, size: 16)
!94 = !DIDerivedType(tag: DW_TAG_member, name: "dest", scope: !90, file: !91, line: 25, baseType: !66, size: 16, offset: 16)
!95 = !DIDerivedType(tag: DW_TAG_member, name: "len", scope: !90, file: !91, line: 26, baseType: !66, size: 16, offset: 32)
!96 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !90, file: !91, line: 27, baseType: !83, size: 16, offset: 48)
!97 = !DILocalVariable(name: "protocol_man", scope: !37, file: !3, line: 49, type: !98)
!98 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !99, size: 64)
!99 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "protocol_management", file: !3, line: 14, size: 64, elements: !100)
!100 = !{!101, !102, !103}
!101 = !DIDerivedType(tag: DW_TAG_member, name: "fpp_prefix", scope: !99, file: !3, line: 15, baseType: !45, size: 32)
!102 = !DIDerivedType(tag: DW_TAG_member, name: "node_offset", scope: !99, file: !3, line: 16, baseType: !17, size: 16, offset: 32)
!103 = !DIDerivedType(tag: DW_TAG_member, name: "packet_size", scope: !99, file: !3, line: 17, baseType: !66, size: 16, offset: 48)
!104 = !DILocalVariable(name: "offset", scope: !105, file: !3, line: 55, type: !40)
!105 = distinct !DILexicalBlock(scope: !106, file: !3, line: 54, column: 46)
!106 = distinct !DILexicalBlock(scope: !37, file: !3, line: 54, column: 6)
!107 = !DILocalVariable(name: "bytes_to_shift", scope: !105, file: !3, line: 56, type: !40)
!108 = !DILocalVariable(name: "node_man", scope: !105, file: !3, line: 64, type: !109)
!109 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !110, size: 64)
!110 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "node_management", file: !3, line: 19, size: 192, elements: !111)
!111 = !{!112, !116, !117}
!112 = !DIDerivedType(tag: DW_TAG_member, name: "interface_id", scope: !110, file: !3, line: 20, baseType: !113, size: 56)
!113 = !DICompositeType(tag: DW_TAG_array_type, baseType: !74, size: 56, elements: !114)
!114 = !{!115}
!115 = !DISubrange(count: 7)
!116 = !DIDerivedType(tag: DW_TAG_member, name: "timestamp_ingress", scope: !110, file: !3, line: 21, baseType: !27, size: 64, offset: 64)
!117 = !DIDerivedType(tag: DW_TAG_member, name: "timestamp_egress", scope: !110, file: !3, line: 22, baseType: !27, size: 64, offset: 128)
!118 = !DILocalVariable(name: "node_man", scope: !119, file: !3, line: 75, type: !109)
!119 = distinct !DILexicalBlock(scope: !106, file: !3, line: 71, column: 9)
!120 = !DILocation(line: 0, scope: !37)
!121 = !DILocation(line: 27, column: 34, scope: !37)
!122 = !{!123, !124, i64 0}
!123 = !{!"xdp_md", !124, i64 0, !124, i64 4, !124, i64 8, !124, i64 12, !124, i64 16}
!124 = !{!"int", !125, i64 0}
!125 = !{!"omnipotent char", !126, i64 0}
!126 = !{!"Simple C/C++ TBAA"}
!127 = !DILocation(line: 27, column: 23, scope: !37)
!128 = !DILocation(line: 28, column: 38, scope: !37)
!129 = !{!123, !124, i64 4}
!130 = !DILocation(line: 28, column: 27, scope: !37)
!131 = !DILocation(line: 28, column: 19, scope: !37)
!132 = !DILocation(line: 29, column: 23, scope: !37)
!133 = !DILocation(line: 31, column: 10, scope: !134)
!134 = distinct !DILexicalBlock(scope: !37, file: !3, line: 31, column: 6)
!135 = !DILocation(line: 31, column: 16, scope: !134)
!136 = !DILocation(line: 31, column: 14, scope: !134)
!137 = !DILocation(line: 31, column: 6, scope: !37)
!138 = !DILocation(line: 27, column: 15, scope: !37)
!139 = !DILocation(line: 34, column: 32, scope: !37)
!140 = !DILocation(line: 36, column: 9, scope: !141)
!141 = distinct !DILexicalBlock(scope: !37, file: !3, line: 36, column: 6)
!142 = !DILocation(line: 36, column: 15, scope: !141)
!143 = !DILocation(line: 36, column: 13, scope: !141)
!144 = !DILocation(line: 36, column: 6, scope: !37)
!145 = !DILocation(line: 39, column: 20, scope: !37)
!146 = !DILocation(line: 39, column: 24, scope: !37)
!147 = !DILocation(line: 41, column: 14, scope: !148)
!148 = distinct !DILexicalBlock(scope: !37, file: !3, line: 41, column: 6)
!149 = !DILocation(line: 41, column: 28, scope: !148)
!150 = !DILocation(line: 41, column: 42, scope: !148)
!151 = !DILocation(line: 41, column: 52, scope: !148)
!152 = !DILocation(line: 41, column: 6, scope: !37)
!153 = !DILocation(line: 46, column: 11, scope: !154)
!154 = distinct !DILexicalBlock(scope: !37, file: !3, line: 46, column: 6)
!155 = !DILocation(line: 46, column: 17, scope: !154)
!156 = !DILocation(line: 46, column: 15, scope: !154)
!157 = !DILocation(line: 46, column: 6, scope: !37)
!158 = !DILocation(line: 51, column: 19, scope: !159)
!159 = distinct !DILexicalBlock(scope: !37, file: !3, line: 51, column: 6)
!160 = !DILocation(line: 51, column: 25, scope: !159)
!161 = !DILocation(line: 51, column: 23, scope: !159)
!162 = !DILocation(line: 51, column: 6, scope: !37)
!163 = !DILocation(line: 54, column: 20, scope: !106)
!164 = !{!165, !124, i64 0}
!165 = !{!"protocol_management", !124, i64 0, !166, i64 4, !166, i64 6}
!166 = !{!"short", !125, i64 0}
!167 = !DILocation(line: 54, column: 31, scope: !106)
!168 = !DILocation(line: 54, column: 6, scope: !37)
!169 = !DILocation(line: 55, column: 16, scope: !105)
!170 = !{!165, !166, i64 4}
!171 = !DILocation(line: 0, scope: !105)
!172 = !DILocation(line: 56, column: 31, scope: !105)
!173 = !DILocation(line: 58, column: 10, scope: !105)
!174 = !DILocation(line: 59, column: 31, scope: !105)
!175 = !DILocation(line: 59, column: 29, scope: !105)
!176 = !DILocation(line: 61, column: 22, scope: !177)
!177 = distinct !DILexicalBlock(scope: !105, file: !3, line: 61, column: 7)
!178 = !DILocation(line: 61, column: 7, scope: !105)
!179 = !DILocation(line: 57, column: 18, scope: !105)
!180 = !DILocation(line: 64, column: 59, scope: !105)
!181 = !DILocation(line: 65, column: 16, scope: !182)
!182 = distinct !DILexicalBlock(scope: !105, file: !3, line: 65, column: 7)
!183 = !DILocation(line: 65, column: 22, scope: !182)
!184 = !DILocation(line: 65, column: 20, scope: !182)
!185 = !DILocation(line: 65, column: 7, scope: !105)
!186 = !DILocation(line: 68, column: 3, scope: !105)
!187 = !DILocation(line: 69, column: 33, scope: !105)
!188 = !DILocation(line: 69, column: 13, scope: !105)
!189 = !DILocation(line: 69, column: 31, scope: !105)
!190 = !{!191, !192, i64 8}
!191 = !{!"node_management", !125, i64 0, !192, i64 8, !192, i64 16}
!192 = !{!"long long", !125, i64 0}
!193 = !DILocation(line: 70, column: 13, scope: !105)
!194 = !DILocation(line: 70, column: 30, scope: !105)
!195 = !{!191, !192, i64 16}
!196 = !DILocation(line: 72, column: 28, scope: !119)
!197 = !DILocation(line: 73, column: 17, scope: !119)
!198 = !DILocation(line: 73, column: 29, scope: !119)
!199 = !DILocation(line: 74, column: 35, scope: !119)
!200 = !{!201, !166, i64 2}
!201 = !{!"iphdr", !125, i64 0, !125, i64 0, !125, i64 1, !166, i64 2, !166, i64 4, !166, i64 6, !125, i64 8, !125, i64 9, !166, i64 10, !124, i64 12, !124, i64 16}
!202 = !DILocation(line: 74, column: 17, scope: !119)
!203 = !DILocation(line: 74, column: 29, scope: !119)
!204 = !{!165, !166, i64 6}
!205 = !DILocation(line: 0, scope: !119)
!206 = !DILocation(line: 77, column: 16, scope: !207)
!207 = distinct !DILexicalBlock(scope: !119, file: !3, line: 77, column: 7)
!208 = !DILocation(line: 77, column: 22, scope: !207)
!209 = !DILocation(line: 77, column: 20, scope: !207)
!210 = !DILocation(line: 77, column: 7, scope: !119)
!211 = !DILocation(line: 80, column: 3, scope: !119)
!212 = !DILocation(line: 81, column: 33, scope: !119)
!213 = !DILocation(line: 81, column: 13, scope: !119)
!214 = !DILocation(line: 81, column: 31, scope: !119)
!215 = !DILocation(line: 82, column: 13, scope: !119)
!216 = !DILocation(line: 82, column: 30, scope: !119)
!217 = !DILocation(line: 85, column: 1, scope: !37)
