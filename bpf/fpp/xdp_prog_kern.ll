; ModuleID = 'xdp_prog_kern.c'
source_filename = "xdp_prog_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-n32:64-S128"
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
define dso_local i32 @profiling_protocol(%struct.xdp_md* nocapture readonly) local_unnamed_addr #0 !dbg !37 {
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !51, metadata !DIExpression()), !dbg !120
  %2 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !121
  %3 = load i32, i32* %2, align 4, !dbg !121, !tbaa !122
  %4 = zext i32 %3 to i64, !dbg !127
  %5 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !128
  %6 = load i32, i32* %5, align 4, !dbg !128, !tbaa !129
  %7 = zext i32 %6 to i64, !dbg !130
  %8 = inttoptr i64 %7 to i8*, !dbg !131
  call void @llvm.dbg.value(metadata i8* %8, metadata !53, metadata !DIExpression()), !dbg !132
  %9 = inttoptr i64 %4 to %struct.ethhdr*, !dbg !133
  call void @llvm.dbg.value(metadata %struct.ethhdr* %9, metadata !54, metadata !DIExpression()), !dbg !134
  %10 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %9, i64 1, !dbg !135
  %11 = inttoptr i64 %7 to %struct.ethhdr*, !dbg !137
  %12 = icmp ugt %struct.ethhdr* %10, %11, !dbg !138
  br i1 %12, label %85, label %13, !dbg !139

; <label>:13:                                     ; preds = %1
  %14 = inttoptr i64 %4 to i8*, !dbg !140
  call void @llvm.dbg.value(metadata i8* %14, metadata !52, metadata !DIExpression()), !dbg !141
  %15 = getelementptr i8, i8* %14, i64 14, !dbg !142
  call void @llvm.dbg.value(metadata i8* %15, metadata !68, metadata !DIExpression()), !dbg !143
  %16 = getelementptr inbounds i8, i8* %14, i64 34, !dbg !144
  %17 = bitcast i8* %16 to %struct.iphdr*, !dbg !144
  %18 = inttoptr i64 %7 to %struct.iphdr*, !dbg !146
  %19 = icmp ugt %struct.iphdr* %17, %18, !dbg !147
  br i1 %19, label %85, label %20, !dbg !148

; <label>:20:                                     ; preds = %13
  %21 = load i8, i8* %15, align 4, !dbg !149
  %22 = shl i8 %21, 2, !dbg !150
  %23 = and i8 %22, 60, !dbg !150
  %24 = icmp ult i8 %23, 20, !dbg !151
  br i1 %24, label %85, label %25, !dbg !153

; <label>:25:                                     ; preds = %20
  %26 = zext i8 %23 to i64, !dbg !154
  call void @llvm.dbg.value(metadata i64 %26, metadata !87, metadata !DIExpression()), !dbg !155
  %27 = getelementptr i8, i8* %15, i64 %26, !dbg !156
  %28 = icmp ugt i8* %27, %8, !dbg !157
  br i1 %28, label %85, label %29, !dbg !158

; <label>:29:                                     ; preds = %25
  call void @llvm.dbg.value(metadata i8* %27, metadata !88, metadata !DIExpression()), !dbg !159
  %30 = getelementptr i8, i8* %27, i64 8, !dbg !160
  %31 = bitcast i8* %30 to %struct.udphdr*, !dbg !160
  %32 = inttoptr i64 %7 to %struct.udphdr*, !dbg !162
  %33 = icmp ugt %struct.udphdr* %31, %32, !dbg !163
  br i1 %33, label %85, label %34, !dbg !164

; <label>:34:                                     ; preds = %29
  call void @llvm.dbg.value(metadata i8* %30, metadata !97, metadata !DIExpression()), !dbg !165
  %35 = getelementptr i8, i8* %30, i64 8, !dbg !166
  %36 = bitcast i8* %35 to %struct.protocol_management*, !dbg !166
  %37 = inttoptr i64 %7 to %struct.protocol_management*, !dbg !168
  %38 = icmp ugt %struct.protocol_management* %36, %37, !dbg !169
  br i1 %38, label %85, label %39, !dbg !170

; <label>:39:                                     ; preds = %34
  %40 = bitcast i8* %30 to i32*, !dbg !171
  %41 = load i32, i32* %40, align 4, !dbg !171, !tbaa !172
  %42 = icmp eq i32 %41, -106959083, !dbg !175
  br i1 %42, label %43, label %67, !dbg !176

; <label>:43:                                     ; preds = %39
  %44 = getelementptr inbounds i8, i8* %30, i64 4, !dbg !177
  %45 = bitcast i8* %44 to i16*, !dbg !177
  %46 = load i16, i16* %45, align 4, !dbg !177, !tbaa !178
  %47 = tail call i16 @llvm.bswap.i16(i16 %46), !dbg !177
  %48 = zext i16 %47 to i32, !dbg !179
  %49 = mul nuw nsw i32 %48, 24, !dbg !180
  %50 = add nuw nsw i32 %49, 8, !dbg !181
  call void @llvm.dbg.value(metadata i32 %50, metadata !107, metadata !DIExpression()), !dbg !182
  %51 = add i16 %47, 1, !dbg !183
  %52 = tail call i16 @llvm.bswap.i16(i16 %51), !dbg !184
  store i16 %52, i16* %45, align 4, !dbg !185, !tbaa !178
  %53 = icmp ugt i32 %50, 499, !dbg !186
  br i1 %53, label %85, label %54, !dbg !188

; <label>:54:                                     ; preds = %43
  %55 = zext i32 %50 to i64, !dbg !189
  %56 = getelementptr i8, i8* %30, i64 %55, !dbg !189
  %57 = getelementptr inbounds i8, i8* %56, i64 24, !dbg !190
  %58 = bitcast i8* %57 to %struct.node_management*, !dbg !190
  %59 = inttoptr i64 %7 to %struct.node_management*, !dbg !192
  %60 = icmp ugt %struct.node_management* %58, %59, !dbg !193
  br i1 %60, label %85, label %61, !dbg !194

; <label>:61:                                     ; preds = %54
  call void @llvm.dbg.value(metadata i8* %56, metadata !108, metadata !DIExpression()), !dbg !195
  %62 = tail call i64 inttoptr (i64 5 to i64 ()*)() #2, !dbg !196
  %63 = getelementptr inbounds i8, i8* %56, i64 8, !dbg !197
  %64 = bitcast i8* %63 to i64*, !dbg !197
  store i64 %62, i64* %64, align 8, !dbg !198, !tbaa !199
  %65 = getelementptr inbounds i8, i8* %56, i64 16, !dbg !202
  %66 = bitcast i8* %65 to i64*, !dbg !202
  store i64 0, i64* %66, align 8, !dbg !203, !tbaa !204
  br label %85

; <label>:67:                                     ; preds = %39
  store i32 -106959083, i32* %40, align 4, !dbg !205, !tbaa !172
  %68 = getelementptr inbounds i8, i8* %30, i64 4, !dbg !206
  %69 = bitcast i8* %68 to i16*, !dbg !206
  store i16 256, i16* %69, align 4, !dbg !207, !tbaa !178
  %70 = getelementptr inbounds i8, i8* %14, i64 16, !dbg !208
  %71 = bitcast i8* %70 to i16*, !dbg !208
  %72 = load i16, i16* %71, align 2, !dbg !208, !tbaa !209
  %73 = getelementptr inbounds i8, i8* %30, i64 6, !dbg !211
  %74 = bitcast i8* %73 to i16*, !dbg !211
  store i16 %72, i16* %74, align 2, !dbg !212, !tbaa !213
  %75 = getelementptr inbounds i8, i8* %35, i64 24, !dbg !214
  %76 = bitcast i8* %75 to %struct.node_management*, !dbg !214
  %77 = inttoptr i64 %7 to %struct.node_management*, !dbg !216
  %78 = icmp ugt %struct.node_management* %76, %77, !dbg !217
  br i1 %78, label %85, label %79, !dbg !218

; <label>:79:                                     ; preds = %67
  call void @llvm.dbg.value(metadata i8* %35, metadata !118, metadata !DIExpression()), !dbg !219
  %80 = tail call i64 inttoptr (i64 5 to i64 ()*)() #2, !dbg !220
  %81 = getelementptr inbounds i8, i8* %35, i64 8, !dbg !221
  %82 = bitcast i8* %81 to i64*, !dbg !221
  store i64 %80, i64* %82, align 8, !dbg !222, !tbaa !199
  %83 = getelementptr inbounds i8, i8* %35, i64 16, !dbg !223
  %84 = bitcast i8* %83 to i64*, !dbg !223
  store i64 0, i64* %84, align 8, !dbg !224, !tbaa !204
  br label %85

; <label>:85:                                     ; preds = %54, %43, %79, %61, %13, %29, %67, %34, %20, %25, %1
  %86 = phi i32 [ 0, %1 ], [ 0, %13 ], [ 0, %25 ], [ 0, %20 ], [ 0, %29 ], [ 0, %34 ], [ 0, %67 ], [ 2, %61 ], [ 2, %79 ], [ 0, %43 ], [ 0, %54 ], !dbg !225
  ret i32 %86, !dbg !226
}

; Function Attrs: nounwind readnone speculatable
declare i16 @llvm.bswap.i16(i16) #1

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!33, !34, !35}
!llvm.ident = !{!36}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 87, type: !29, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 7.0.1-8+deb10u2 (tags/RELEASE_701/final)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !14, globals: !20)
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
!18 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "/root/ba-garrido/code/bpf/fpp")
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
!33 = !{i32 2, !"Dwarf Version", i32 4}
!34 = !{i32 2, !"Debug Info Version", i32 3}
!35 = !{i32 1, !"wchar_size", i32 4}
!36 = !{!"clang version 7.0.1-8+deb10u2 (tags/RELEASE_701/final)"}
!37 = distinct !DISubprogram(name: "profiling_protocol", scope: !3, file: !3, line: 25, type: !38, isLocal: false, isDefinition: true, scopeLine: 25, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !50)
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
!56 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ethhdr", file: !57, line: 161, size: 112, elements: !58)
!57 = !DIFile(filename: "/usr/include/linux/if_ether.h", directory: "/root/ba-garrido/code/bpf/fpp")
!58 = !{!59, !64, !65}
!59 = !DIDerivedType(tag: DW_TAG_member, name: "h_dest", scope: !56, file: !57, line: 162, baseType: !60, size: 48)
!60 = !DICompositeType(tag: DW_TAG_array_type, baseType: !61, size: 48, elements: !62)
!61 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!62 = !{!63}
!63 = !DISubrange(count: 6)
!64 = !DIDerivedType(tag: DW_TAG_member, name: "h_source", scope: !56, file: !57, line: 163, baseType: !60, size: 48, offset: 48)
!65 = !DIDerivedType(tag: DW_TAG_member, name: "h_proto", scope: !56, file: !57, line: 164, baseType: !66, size: 16, offset: 96)
!66 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !67, line: 25, baseType: !17)
!67 = !DIFile(filename: "/usr/include/linux/types.h", directory: "/root/ba-garrido/code/bpf/fpp")
!68 = !DILocalVariable(name: "ip", scope: !37, file: !3, line: 34, type: !69)
!69 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !70, size: 64)
!70 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iphdr", file: !71, line: 86, size: 160, elements: !72)
!71 = !DIFile(filename: "/usr/include/linux/ip.h", directory: "/root/ba-garrido/code/bpf/fpp")
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
!91 = !DIFile(filename: "/usr/include/linux/udp.h", directory: "/root/ba-garrido/code/bpf/fpp")
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
!120 = !DILocation(line: 25, column: 39, scope: !37)
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
!132 = !DILocation(line: 28, column: 8, scope: !37)
!133 = !DILocation(line: 29, column: 23, scope: !37)
!134 = !DILocation(line: 29, column: 17, scope: !37)
!135 = !DILocation(line: 31, column: 10, scope: !136)
!136 = distinct !DILexicalBlock(scope: !37, file: !3, line: 31, column: 6)
!137 = !DILocation(line: 31, column: 16, scope: !136)
!138 = !DILocation(line: 31, column: 14, scope: !136)
!139 = !DILocation(line: 31, column: 6, scope: !37)
!140 = !DILocation(line: 27, column: 15, scope: !37)
!141 = !DILocation(line: 27, column: 8, scope: !37)
!142 = !DILocation(line: 34, column: 32, scope: !37)
!143 = !DILocation(line: 34, column: 16, scope: !37)
!144 = !DILocation(line: 36, column: 9, scope: !145)
!145 = distinct !DILexicalBlock(scope: !37, file: !3, line: 36, column: 6)
!146 = !DILocation(line: 36, column: 15, scope: !145)
!147 = !DILocation(line: 36, column: 13, scope: !145)
!148 = !DILocation(line: 36, column: 6, scope: !37)
!149 = !DILocation(line: 39, column: 20, scope: !37)
!150 = !DILocation(line: 39, column: 24, scope: !37)
!151 = !DILocation(line: 41, column: 14, scope: !152)
!152 = distinct !DILexicalBlock(scope: !37, file: !3, line: 41, column: 6)
!153 = !DILocation(line: 41, column: 28, scope: !152)
!154 = !DILocation(line: 41, column: 6, scope: !152)
!155 = !DILocation(line: 39, column: 6, scope: !37)
!156 = !DILocation(line: 41, column: 42, scope: !152)
!157 = !DILocation(line: 41, column: 52, scope: !152)
!158 = !DILocation(line: 41, column: 6, scope: !37)
!159 = !DILocation(line: 44, column: 17, scope: !37)
!160 = !DILocation(line: 46, column: 11, scope: !161)
!161 = distinct !DILexicalBlock(scope: !37, file: !3, line: 46, column: 6)
!162 = !DILocation(line: 46, column: 17, scope: !161)
!163 = !DILocation(line: 46, column: 15, scope: !161)
!164 = !DILocation(line: 46, column: 6, scope: !37)
!165 = !DILocation(line: 49, column: 30, scope: !37)
!166 = !DILocation(line: 51, column: 19, scope: !167)
!167 = distinct !DILexicalBlock(scope: !37, file: !3, line: 51, column: 6)
!168 = !DILocation(line: 51, column: 25, scope: !167)
!169 = !DILocation(line: 51, column: 23, scope: !167)
!170 = !DILocation(line: 51, column: 6, scope: !37)
!171 = !DILocation(line: 54, column: 20, scope: !106)
!172 = !{!173, !124, i64 0}
!173 = !{!"protocol_management", !124, i64 0, !174, i64 4, !174, i64 6}
!174 = !{!"short", !125, i64 0}
!175 = !DILocation(line: 54, column: 31, scope: !106)
!176 = !DILocation(line: 54, column: 6, scope: !37)
!177 = !DILocation(line: 55, column: 16, scope: !105)
!178 = !{!173, !174, i64 4}
!179 = !DILocation(line: 56, column: 24, scope: !105)
!180 = !DILocation(line: 56, column: 31, scope: !105)
!181 = !DILocation(line: 57, column: 18, scope: !105)
!182 = !DILocation(line: 56, column: 7, scope: !105)
!183 = !DILocation(line: 58, column: 10, scope: !105)
!184 = !DILocation(line: 59, column: 31, scope: !105)
!185 = !DILocation(line: 59, column: 29, scope: !105)
!186 = !DILocation(line: 61, column: 22, scope: !187)
!187 = distinct !DILexicalBlock(scope: !105, file: !3, line: 61, column: 7)
!188 = !DILocation(line: 61, column: 7, scope: !105)
!189 = !DILocation(line: 64, column: 59, scope: !105)
!190 = !DILocation(line: 65, column: 16, scope: !191)
!191 = distinct !DILexicalBlock(scope: !105, file: !3, line: 65, column: 7)
!192 = !DILocation(line: 65, column: 22, scope: !191)
!193 = !DILocation(line: 65, column: 20, scope: !191)
!194 = !DILocation(line: 65, column: 7, scope: !105)
!195 = !DILocation(line: 64, column: 27, scope: !105)
!196 = !DILocation(line: 69, column: 33, scope: !105)
!197 = !DILocation(line: 69, column: 13, scope: !105)
!198 = !DILocation(line: 69, column: 31, scope: !105)
!199 = !{!200, !201, i64 8}
!200 = !{!"node_management", !125, i64 0, !201, i64 8, !201, i64 16}
!201 = !{!"long long", !125, i64 0}
!202 = !DILocation(line: 70, column: 13, scope: !105)
!203 = !DILocation(line: 70, column: 30, scope: !105)
!204 = !{!200, !201, i64 16}
!205 = !DILocation(line: 72, column: 28, scope: !119)
!206 = !DILocation(line: 73, column: 17, scope: !119)
!207 = !DILocation(line: 73, column: 29, scope: !119)
!208 = !DILocation(line: 74, column: 35, scope: !119)
!209 = !{!210, !174, i64 2}
!210 = !{!"iphdr", !125, i64 0, !125, i64 0, !125, i64 1, !174, i64 2, !174, i64 4, !174, i64 6, !125, i64 8, !125, i64 9, !174, i64 10, !124, i64 12, !124, i64 16}
!211 = !DILocation(line: 74, column: 17, scope: !119)
!212 = !DILocation(line: 74, column: 29, scope: !119)
!213 = !{!173, !174, i64 6}
!214 = !DILocation(line: 77, column: 16, scope: !215)
!215 = distinct !DILexicalBlock(scope: !119, file: !3, line: 77, column: 7)
!216 = !DILocation(line: 77, column: 22, scope: !215)
!217 = !DILocation(line: 77, column: 20, scope: !215)
!218 = !DILocation(line: 77, column: 7, scope: !119)
!219 = !DILocation(line: 75, column: 27, scope: !119)
!220 = !DILocation(line: 81, column: 33, scope: !119)
!221 = !DILocation(line: 81, column: 13, scope: !119)
!222 = !DILocation(line: 81, column: 31, scope: !119)
!223 = !DILocation(line: 82, column: 13, scope: !119)
!224 = !DILocation(line: 82, column: 30, scope: !119)
!225 = !DILocation(line: 0, scope: !145)
!226 = !DILocation(line: 85, column: 1, scope: !37)
