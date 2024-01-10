; ModuleID = 'C:/Users/Alex/Desktop/vitis-projects/adder/solution1/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

; Function Attrs: inaccessiblemem_or_argmemonly noinline
define i1 @apatb_carry_lookahead_adder_ir(i1* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="16" %a, i1* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="16" %b, i1* noalias nocapture nonnull "fpga.decayed.dim.hint"="16" %sum) local_unnamed_addr #0 {
entry:
  %a_copy = alloca [16 x i1], align 512
  %b_copy = alloca [16 x i1], align 512
  %sum_copy = alloca [16 x i1], align 512
  %0 = bitcast i1* %a to [16 x i1]*
  %1 = bitcast i1* %b to [16 x i1]*
  %2 = bitcast i1* %sum to [16 x i1]*
  call fastcc void @copy_in([16 x i1]* nonnull %0, [16 x i1]* nonnull align 512 %a_copy, [16 x i1]* nonnull %1, [16 x i1]* nonnull align 512 %b_copy, [16 x i1]* nonnull %2, [16 x i1]* nonnull align 512 %sum_copy)
  %3 = getelementptr inbounds [16 x i1], [16 x i1]* %a_copy, i32 0, i32 0
  %4 = getelementptr inbounds [16 x i1], [16 x i1]* %b_copy, i32 0, i32 0
  %5 = getelementptr inbounds [16 x i1], [16 x i1]* %sum_copy, i32 0, i32 0
  %6 = call i1 @apatb_carry_lookahead_adder_hw(i1* %3, i1* %4, i1* %5)
  call void @copy_back([16 x i1]* %0, [16 x i1]* %a_copy, [16 x i1]* %1, [16 x i1]* %b_copy, [16 x i1]* %2, [16 x i1]* %sum_copy)
  ret i1 %6
}

; Function Attrs: argmemonly noinline norecurse
define internal fastcc void @copy_in([16 x i1]* noalias readonly, [16 x i1]* noalias align 512, [16 x i1]* noalias readonly, [16 x i1]* noalias align 512, [16 x i1]* noalias readonly, [16 x i1]* noalias align 512) unnamed_addr #1 {
entry:
  call fastcc void @onebyonecpy_hls.p0a16i1([16 x i1]* align 512 %1, [16 x i1]* %0)
  call fastcc void @onebyonecpy_hls.p0a16i1([16 x i1]* align 512 %3, [16 x i1]* %2)
  call fastcc void @onebyonecpy_hls.p0a16i1([16 x i1]* align 512 %5, [16 x i1]* %4)
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define internal fastcc void @onebyonecpy_hls.p0a16i1([16 x i1]* noalias align 512, [16 x i1]* noalias readonly) unnamed_addr #2 {
entry:
  %2 = icmp eq [16 x i1]* %0, null
  %3 = icmp eq [16 x i1]* %1, null
  %4 = or i1 %2, %3
  br i1 %4, label %ret, label %copy

copy:                                             ; preds = %entry
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %copy
  %for.loop.idx1 = phi i64 [ 0, %copy ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [16 x i1], [16 x i1]* %0, i64 0, i64 %for.loop.idx1
  %src.addr = getelementptr [16 x i1], [16 x i1]* %1, i64 0, i64 %for.loop.idx1
  %5 = bitcast i1* %src.addr to i8*
  %6 = load i8, i8* %5
  %7 = trunc i8 %6 to i1
  store i1 %7, i1* %dst.addr, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx1, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, 16
  br i1 %exitcond, label %for.loop, label %ret

ret:                                              ; preds = %for.loop, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define internal fastcc void @copy_out([16 x i1]* noalias, [16 x i1]* noalias readonly align 512, [16 x i1]* noalias, [16 x i1]* noalias readonly align 512, [16 x i1]* noalias, [16 x i1]* noalias readonly align 512) unnamed_addr #3 {
entry:
  call fastcc void @onebyonecpy_hls.p0a16i1([16 x i1]* %0, [16 x i1]* align 512 %1)
  call fastcc void @onebyonecpy_hls.p0a16i1([16 x i1]* %2, [16 x i1]* align 512 %3)
  call fastcc void @onebyonecpy_hls.p0a16i1([16 x i1]* %4, [16 x i1]* align 512 %5)
  ret void
}

declare i1 @apatb_carry_lookahead_adder_hw(i1*, i1*, i1*)

; Function Attrs: argmemonly noinline norecurse
define internal fastcc void @copy_back([16 x i1]* noalias, [16 x i1]* noalias readonly align 512, [16 x i1]* noalias, [16 x i1]* noalias readonly align 512, [16 x i1]* noalias, [16 x i1]* noalias readonly align 512) unnamed_addr #3 {
entry:
  call fastcc void @onebyonecpy_hls.p0a16i1([16 x i1]* %4, [16 x i1]* align 512 %5)
  ret void
}

define i1 @carry_lookahead_adder_hw_stub_wrapper(i1*, i1*, i1*) #4 {
entry:
  %3 = bitcast i1* %0 to [16 x i1]*
  %4 = bitcast i1* %1 to [16 x i1]*
  %5 = bitcast i1* %2 to [16 x i1]*
  call void @copy_out([16 x i1]* null, [16 x i1]* %3, [16 x i1]* null, [16 x i1]* %4, [16 x i1]* null, [16 x i1]* %5)
  %6 = bitcast [16 x i1]* %3 to i1*
  %7 = bitcast [16 x i1]* %4 to i1*
  %8 = bitcast [16 x i1]* %5 to i1*
  %9 = call i1 @carry_lookahead_adder_hw_stub(i1* %6, i1* %7, i1* %8)
  call void @copy_in([16 x i1]* null, [16 x i1]* %3, [16 x i1]* null, [16 x i1]* %4, [16 x i1]* null, [16 x i1]* %5)
  ret i1 %9
}

declare i1 @carry_lookahead_adder_hw_stub(i1*, i1*, i1*)

attributes #0 = { inaccessiblemem_or_argmemonly noinline "fpga.wrapper.func"="wrapper" }
attributes #1 = { argmemonly noinline norecurse "fpga.wrapper.func"="copyin" }
attributes #2 = { argmemonly noinline norecurse "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #3 = { argmemonly noinline norecurse "fpga.wrapper.func"="copyout" }
attributes #4 = { "fpga.wrapper.func"="stub" }

!llvm.dbg.cu = !{}
!llvm.ident = !{!0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0}
!llvm.module.flags = !{!1, !2, !3}
!blackbox_cfg = !{!4}

!0 = !{!"clang version 7.0.0 "}
!1 = !{i32 2, !"Dwarf Version", i32 4}
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{}
