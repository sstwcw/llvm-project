; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

declare void @llvm.assume(i1)
declare void @barrier()
declare void @use.i8(i8)

; Test case of X comp X^Neg_C, which have Transform to SLT.
; X s< X^Neg_C  -->  X s< 0
define i1 @src_slt(i8 %x) {
; CHECK-LABEL: @src_slt(
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i8 [[X:%.*]], 0
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %not = xor i8 %x, -1
  %cmp = icmp slt i8 %x, %not
  ret i1 %cmp
}

define <2 x i1> @src_slt_vec(<2 x i8> %x) {
; CHECK-LABEL: @src_slt_vec(
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt <2 x i8> [[X:%.*]], zeroinitializer
; CHECK-NEXT:    ret <2 x i1> [[CMP]]
;
  %not = xor <2 x i8> %x, <i8 -1, i8 -1>
  %cmp = icmp slt <2 x i8> %x, %not
  ret <2 x i1> %cmp
}

; X s<= X^Neg_C  -->  X s< 0
define i1 @src_sle(i8 %x) {
; CHECK-LABEL: @src_sle(
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i8 [[X:%.*]], 0
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %not = xor i8 %x, -1
  %cmp = icmp sle i8 %x, %not
  ret i1 %cmp
}

define <2 x i1> @src_sle_vec(<2 x i8> %x) {
; CHECK-LABEL: @src_sle_vec(
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt <2 x i8> [[X:%.*]], zeroinitializer
; CHECK-NEXT:    ret <2 x i1> [[CMP]]
;
  %not = xor <2 x i8> %x, <i8 -1, i8 -1>
  %cmp = icmp sle <2 x i8> %x, %not
  ret <2 x i1> %cmp
}

; X u> X^Neg_C  -->  X s< 0
define i1 @src_ugt(i8 %x) {
; CHECK-LABEL: @src_ugt(
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i8 [[X:%.*]], 0
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %not = xor i8 %x, -1
  %cmp = icmp ugt i8 %x, %not
  ret i1 %cmp
}

define <2 x i1> @src_ugt_vec(<2 x i8> %x) {
; CHECK-LABEL: @src_ugt_vec(
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt <2 x i8> [[X:%.*]], zeroinitializer
; CHECK-NEXT:    ret <2 x i1> [[CMP]]
;
  %not = xor <2 x i8> %x, <i8 -1, i8 -1>
  %cmp = icmp ugt <2 x i8> %x, %not
  ret <2 x i1> %cmp
}

; X u>= X^Neg_C  -->  X s< 0
define i1 @src_uge(i8 %x) {
; CHECK-LABEL: @src_uge(
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i8 [[X:%.*]], 0
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %not = xor i8 %x, -1
  %cmp = icmp uge i8 %x, %not
  ret i1 %cmp
}

define <2 x i1> @src_uge_vec(<2 x i8> %x) {
; CHECK-LABEL: @src_uge_vec(
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt <2 x i8> [[X:%.*]], zeroinitializer
; CHECK-NEXT:    ret <2 x i1> [[CMP]]
;
  %not = xor <2 x i8> %x, <i8 -1, i8 -1>
  %cmp = icmp uge <2 x i8> %x, %not
  ret <2 x i1> %cmp
}

define <2 x i1> @src_uge_vec_min(<2 x i8> %x) {
; CHECK-LABEL: @src_uge_vec_min(
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt <2 x i8> [[X:%.*]], zeroinitializer
; CHECK-NEXT:    ret <2 x i1> [[CMP]]
;
  %not = xor <2 x i8> %x, <i8 -128, i8 -128>
  %cmp = icmp uge <2 x i8> %x, %not
  ret <2 x i1> %cmp
}

define <2 x i1> @src_uge_vec_128(<2 x i128> %x) {
; CHECK-LABEL: @src_uge_vec_128(
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt <2 x i128> [[X:%.*]], zeroinitializer
; CHECK-NEXT:    ret <2 x i1> [[CMP]]
;
  %not = xor <2 x i128> %x, <i128 -170141183460469231731687303715884105728, i128 -170141183460469231731687303715884105728>
  %cmp = icmp uge <2 x i128> %x, %not
  ret <2 x i1> %cmp
}

; Test case of X comp X^Neg_C, which have Transform to SGT.
; X s> X^Neg_C  -->  X s> -1
define i1 @src_sgt(i8 %x) {
; CHECK-LABEL: @src_sgt(
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i8 [[X:%.*]], -1
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %not = xor i8 %x, -1
  %cmp = icmp sgt i8 %x, %not
  ret i1 %cmp
}

define <2 x i1> @src_sgt_vec(<2 x i8> %x) {
; CHECK-LABEL: @src_sgt_vec(
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt <2 x i8> [[X:%.*]], splat (i8 -1)
; CHECK-NEXT:    ret <2 x i1> [[CMP]]
;
  %not = xor <2 x i8> %x, <i8 -1, i8 -1>
  %cmp = icmp sgt <2 x i8> %x, %not
  ret <2 x i1> %cmp
}

; X s>= X^Neg_C  -->  X s> -1
define i1 @src_sge(i8 %x) {
; CHECK-LABEL: @src_sge(
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i8 [[X:%.*]], -1
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %not = xor i8 %x, -1
  %cmp = icmp sge i8 %x, %not
  ret i1 %cmp
}

define <2 x i1> @src_sge_vec(<2 x i8> %x) {
; CHECK-LABEL: @src_sge_vec(
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt <2 x i8> [[X:%.*]], splat (i8 -1)
; CHECK-NEXT:    ret <2 x i1> [[CMP]]
;
  %not = xor <2 x i8> %x, <i8 -1, i8 -1>
  %cmp = icmp sge <2 x i8> %x, %not
  ret <2 x i1> %cmp
}

; X u< X^Neg_C  -->  X s> -1
define i1 @src_ult(i8 %x) {
; CHECK-LABEL: @src_ult(
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i8 [[X:%.*]], -1
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %not = xor i8 %x, -1
  %cmp = icmp ult i8 %x, %not
  ret i1 %cmp
}

define <2 x i1> @src_ult_vec(<2 x i8> %x) {
; CHECK-LABEL: @src_ult_vec(
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt <2 x i8> [[X:%.*]], splat (i8 -1)
; CHECK-NEXT:    ret <2 x i1> [[CMP]]
;
  %not = xor <2 x i8> %x, <i8 -1, i8 -1>
  %cmp = icmp ult <2 x i8> %x, %not
  ret <2 x i1> %cmp
}

; X u<= X^Neg_C  -->  X s> -1
define i1 @src_ule(i8 %x) {
; CHECK-LABEL: @src_ule(
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i8 [[X:%.*]], -1
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %not = xor i8 %x, -1
  %cmp = icmp ule i8 %x, %not
  ret i1 %cmp
}

define <2 x i1> @src_ule_vec(<2 x i8> %x) {
; CHECK-LABEL: @src_ule_vec(
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt <2 x i8> [[X:%.*]], splat (i8 -1)
; CHECK-NEXT:    ret <2 x i1> [[CMP]]
;
  %not = xor <2 x i8> %x, <i8 -1, i8 -1>
  %cmp = icmp ule <2 x i8> %x, %not
  ret <2 x i1> %cmp
}

define <2 x i1> @src_ule_vec_min(<2 x i8> %x) {
; CHECK-LABEL: @src_ule_vec_min(
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt <2 x i8> [[X:%.*]], splat (i8 -1)
; CHECK-NEXT:    ret <2 x i1> [[CMP]]
;
  %not = xor <2 x i8> %x, <i8 -128, i8 -128>
  %cmp = icmp ule <2 x i8> %x, %not
  ret <2 x i1> %cmp
}

define <2 x i1> @src_ule_vec_128(<2 x i128> %x) {
; CHECK-LABEL: @src_ule_vec_128(
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt <2 x i128> [[X:%.*]], splat (i128 -1)
; CHECK-NEXT:    ret <2 x i1> [[CMP]]
;
  %not = xor <2 x i128> %x, <i128 -170141183460469231731687303715884105728, i128 -170141183460469231731687303715884105728>
  %cmp = icmp ule <2 x i128> %x, %not
  ret <2 x i1> %cmp
}

; X comp X^Neg_C tests. negative
; X comp Y
define i1 @src_sle_xny(i8 %x, i8 %y) {
; CHECK-LABEL: @src_sle_xny(
; CHECK-NEXT:    [[Y_NOT:%.*]] = xor i8 [[Y:%.*]], -1
; CHECK-NEXT:    [[CMP:%.*]] = icmp sle i8 [[X:%.*]], [[Y_NOT]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %y.not = xor i8 %y, -1
  %cmp = icmp sle i8 %x, %y.not
  ret i1 %cmp
}
define i1 @src_sle_nyx(i8 %x, i8 %y) {
; CHECK-LABEL: @src_sle_nyx(
; CHECK-NEXT:    [[Y_NOT:%.*]] = xor i8 [[Y:%.*]], -1
; CHECK-NEXT:    [[CMP:%.*]] = icmp sge i8 [[X:%.*]], [[Y_NOT]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %y.not = xor i8 %y, -1
  %cmp = icmp sle i8 %y.not, %x
  ret i1 %cmp
}
define i1 @src_sge_xny(i8 %x, i8 %y) {
; CHECK-LABEL: @src_sge_xny(
; CHECK-NEXT:    [[Y_NOT:%.*]] = xor i8 [[Y:%.*]], -1
; CHECK-NEXT:    [[CMP:%.*]] = icmp sge i8 [[X:%.*]], [[Y_NOT]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %y.not = xor i8 %y, -1
  %cmp = icmp sge i8 %x, %y.not
  ret i1 %cmp
}
define i1 @src_sge_nyx(i8 %x, i8 %y) {
; CHECK-LABEL: @src_sge_nyx(
; CHECK-NEXT:    [[Y_NOT:%.*]] = xor i8 [[Y:%.*]], -1
; CHECK-NEXT:    [[CMP:%.*]] = icmp sle i8 [[X:%.*]], [[Y_NOT]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %y.not = xor i8 %y, -1
  %cmp = icmp sge i8 %y.not, %x
  ret i1 %cmp
}
define i1 @src_ule_xny(i8 %x, i8 %y) {
; CHECK-LABEL: @src_ule_xny(
; CHECK-NEXT:    [[Y_NOT:%.*]] = xor i8 [[Y:%.*]], -1
; CHECK-NEXT:    [[CMP:%.*]] = icmp ule i8 [[X:%.*]], [[Y_NOT]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %y.not = xor i8 %y, -1
  %cmp = icmp ule i8 %x, %y.not
  ret i1 %cmp
}
define i1 @src_ule_nyx(i8 %x, i8 %y) {
; CHECK-LABEL: @src_ule_nyx(
; CHECK-NEXT:    [[Y_NOT:%.*]] = xor i8 [[Y:%.*]], -1
; CHECK-NEXT:    [[CMP:%.*]] = icmp uge i8 [[X:%.*]], [[Y_NOT]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %y.not = xor i8 %y, -1
  %cmp = icmp ule i8 %y.not, %x
  ret i1 %cmp
}
define i1 @src_uge_xny(i8 %x, i8 %y) {
; CHECK-LABEL: @src_uge_xny(
; CHECK-NEXT:    [[Y_NOT:%.*]] = xor i8 [[Y:%.*]], -1
; CHECK-NEXT:    [[CMP:%.*]] = icmp uge i8 [[X:%.*]], [[Y_NOT]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %y.not = xor i8 %y, -1
  %cmp = icmp uge i8 %x, %y.not
  ret i1 %cmp
}
define i1 @src_uge_nyx(i8 %x, i8 %y) {
; CHECK-LABEL: @src_uge_nyx(
; CHECK-NEXT:    [[Y_NOT:%.*]] = xor i8 [[Y:%.*]], -1
; CHECK-NEXT:    [[CMP:%.*]] = icmp ule i8 [[X:%.*]], [[Y_NOT]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %y.not = xor i8 %y, -1
  %cmp = icmp uge i8 %y.not, %x
  ret i1 %cmp
}

; X comp X^Neg_C tests. negative
; (X+1) comp X^Neg_C
define i1 @src_sle_incx_nx(i8 %x) {
; CHECK-LABEL: @src_sle_incx_nx(
; CHECK-NEXT:    [[TMP1:%.*]] = sub i8 -2, [[X:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp sge i8 [[TMP1]], [[X]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %nx = xor i8 %x, -1
  %inc.x = add i8 %x, 1
  %cmp = icmp sle i8 %inc.x, %nx
  ret i1 %cmp
}
; (X-1) comp X^Neg_C
define i1 @src_sle_decx_nx(i8 %x) {
; CHECK-LABEL: @src_sle_decx_nx(
; CHECK-NEXT:    [[TMP1:%.*]] = sub i8 0, [[X:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp sle i8 [[X]], [[TMP1]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %nx = xor i8 %x, -1
  %dec.x = add i8 %x, -1
  %cmp = icmp sle i8 %dec.x, %nx
  ret i1 %cmp
}
; X comp (X+1)^Neg_C
define i1 @src_sle_x_nincx(i8 %x) {
; CHECK-LABEL: @src_sle_x_nincx(
; CHECK-NEXT:    [[NOT_INC_X:%.*]] = sub i8 -2, [[X:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp sle i8 [[X]], [[NOT_INC_X]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %inc.x = add i8 %x, 1
  %not.inc.x = xor i8 %inc.x, -1
  %cmp = icmp sle i8 %x, %not.inc.x
  ret i1 %cmp
}
; X comp (X-1)^Neg_C
define i1 @src_sle_x_ndecx(i8 %x) {
; CHECK-LABEL: @src_sle_x_ndecx(
; CHECK-NEXT:    [[NOT_DEC_X:%.*]] = sub i8 0, [[X:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp sle i8 [[X]], [[NOT_DEC_X]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %dec.x = add i8 %x, -1
  %not.dec.x = xor i8 %dec.x, -1
  %cmp = icmp sle i8 %x, %not.dec.x
  ret i1 %cmp
}

; test for (~x ^ y) < ~z
define i1 @test_xor1(i8 %x, i8 %y, i8 %z) {
; CHECK-LABEL: @test_xor1(
; CHECK-NEXT:    [[XOR:%.*]] = xor i8 [[X:%.*]], -1
; CHECK-NEXT:    call void @use.i8(i8 [[XOR]])
; CHECK-NEXT:    [[TMP1:%.*]] = xor i8 [[Y:%.*]], [[X]]
; CHECK-NEXT:    [[R:%.*]] = icmp sgt i8 [[TMP1]], [[Z:%.*]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %xor = xor i8 %x, -1
  call void @use.i8(i8 %xor)
  %xor2 = xor i8 %xor, %y
  %nz = xor i8 %z, -1
  %r = icmp slt i8 %xor2, %nz
  ret i1 %r
}

; test for ~z <= (x ^ ~y)
define i1 @test_xor2(i8 %x, i8 %y, i8 %z) {
; CHECK-LABEL: @test_xor2(
; CHECK-NEXT:    [[XOR:%.*]] = xor i8 [[Y:%.*]], -1
; CHECK-NEXT:    call void @use.i8(i8 [[XOR]])
; CHECK-NEXT:    [[TMP1:%.*]] = xor i8 [[X:%.*]], [[Y]]
; CHECK-NEXT:    [[R:%.*]] = icmp sle i8 [[TMP1]], [[Z:%.*]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %nz = xor i8 %z, -1
  %xor = xor i8 %y, -1
  call void @use.i8(i8 %xor)
  %xor2 = xor i8 %xor, %x
  %r = icmp sle i8 %nz, %xor2
  ret i1 %r
}

; test for ~z > (~x ^ y)
define i1 @test_xor3(i8 %x, i8 %y, i8 %z) {
; CHECK-LABEL: @test_xor3(
; CHECK-NEXT:    [[XOR:%.*]] = xor i8 [[X:%.*]], -1
; CHECK-NEXT:    call void @use.i8(i8 [[XOR]])
; CHECK-NEXT:    [[TMP1:%.*]] = xor i8 [[Y:%.*]], [[X]]
; CHECK-NEXT:    [[R:%.*]] = icmp sgt i8 [[TMP1]], [[Z:%.*]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %nz = xor i8 %z, -1
  %xor = xor i8 %x, -1
  call void @use.i8(i8 %xor)
  %xor2 = xor i8 %xor, %y
  %r = icmp sgt i8 %nz, %xor2
  ret i1 %r
}

; tests for equality
define i1 @test_xor_ne(i8 %x, i8 %y, i8 %z) {
; CHECK-LABEL: @test_xor_ne(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i8 [[Y:%.*]], [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp ne i8 [[Z:%.*]], [[TMP1]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %nz = xor i8 %z, -1
  %xor = xor i8 %y, -1
  %xor2 = xor i8 %xor, %x
  %r = icmp ne i8 %nz, %xor2
  ret i1 %r
}

define i1 @test_xor_eq(i8 %x, i8 %y, i8 %z) {
; CHECK-LABEL: @test_xor_eq(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i8 [[Y:%.*]], [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp eq i8 [[Z:%.*]], [[TMP1]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %nz = xor i8 %z, -1
  %xor = xor i8 %y, -1
  %xor2 = xor i8 %xor, %x
  %r = icmp eq i8 %nz, %xor2
  ret i1 %r
}

; other tests
define i1 @test_xor4(i8 %x, i8 %y, i8 %z) {
; CHECK-LABEL: @test_xor4(
; CHECK-NEXT:    [[XOR:%.*]] = xor i8 [[X:%.*]], -1
; CHECK-NEXT:    call void @use.i8(i8 [[XOR]])
; CHECK-NEXT:    [[TMP1:%.*]] = xor i8 [[Y:%.*]], [[X]]
; CHECK-NEXT:    [[R:%.*]] = icmp sle i8 [[TMP1]], [[Z:%.*]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %nz = xor i8 %z, -1
  %xor = xor i8 %x, -1
  call void @use.i8(i8 %xor)
  %xor2 = xor i8 %xor, %y
  %r = icmp sge i8 %xor2, %nz
  ret i1 %r
}

define i1 @test_xor5(i8 %x, i8 %y, i8 %z) {
; CHECK-LABEL: @test_xor5(
; CHECK-NEXT:    [[XOR:%.*]] = xor i8 [[X:%.*]], -1
; CHECK-NEXT:    call void @use.i8(i8 [[XOR]])
; CHECK-NEXT:    [[TMP1:%.*]] = xor i8 [[Y:%.*]], [[X]]
; CHECK-NEXT:    [[R:%.*]] = icmp ugt i8 [[TMP1]], [[Z:%.*]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %nz = xor i8 %z, -1
  %xor = xor i8 %x, -1
  call void @use.i8(i8 %xor)
  %xor2 = xor i8 %xor, %y
  %r = icmp ult i8 %xor2, %nz
  ret i1 %r
}

define i1 @test_xor6(i8 %x, i8 %y, i8 %z) {
; CHECK-LABEL: @test_xor6(
; CHECK-NEXT:    [[XOR:%.*]] = xor i8 [[X:%.*]], -1
; CHECK-NEXT:    call void @use.i8(i8 [[XOR]])
; CHECK-NEXT:    [[TMP1:%.*]] = xor i8 [[Y:%.*]], [[X]]
; CHECK-NEXT:    [[R:%.*]] = icmp uge i8 [[TMP1]], [[Z:%.*]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %nz = xor i8 %z, -1
  %xor = xor i8 %x, -1
  call void @use.i8(i8 %xor)
  %xor2 = xor i8 %xor, %y
  %r = icmp ule i8 %xor2, %nz
  ret i1 %r
}

define i1 @test_xor7(i8 %x, i8 %y, i8 %z) {
; CHECK-LABEL: @test_xor7(
; CHECK-NEXT:    [[XOR:%.*]] = xor i8 [[X:%.*]], -1
; CHECK-NEXT:    call void @use.i8(i8 [[XOR]])
; CHECK-NEXT:    [[TMP1:%.*]] = xor i8 [[Y:%.*]], [[X]]
; CHECK-NEXT:    [[R:%.*]] = icmp ult i8 [[TMP1]], [[Z:%.*]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %nz = xor i8 %z, -1
  %xor = xor i8 %x, -1
  call void @use.i8(i8 %xor)
  %xor2 = xor i8 %xor, %y
  %r = icmp ugt i8 %xor2, %nz
  ret i1 %r
}

define i1 @test_xor8(i8 %x, i8 %y, i8 %z) {
; CHECK-LABEL: @test_xor8(
; CHECK-NEXT:    [[XOR:%.*]] = xor i8 [[X:%.*]], -1
; CHECK-NEXT:    call void @use.i8(i8 [[XOR]])
; CHECK-NEXT:    [[TMP1:%.*]] = xor i8 [[Y:%.*]], [[X]]
; CHECK-NEXT:    [[R:%.*]] = icmp ule i8 [[TMP1]], [[Z:%.*]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %nz = xor i8 %z, -1
  %xor = xor i8 %x, -1
  call void @use.i8(i8 %xor)
  %xor2 = xor i8 %xor, %y
  %r = icmp uge i8 %xor2, %nz
  ret i1 %r
}

; test (~a ^ b) < ~a
define i1 @test_slt_xor(i32 %x, i32 %y) {
; CHECK-LABEL: @test_slt_xor(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i32 [[Y:%.*]], [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp sgt i32 [[TMP1]], [[X]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %xor1 = xor i32 %x, -1
  %xor2 = xor i32 %xor1, %y
  %r = icmp slt i32 %xor2, %xor1
  ret i1 %r
}

; test (a ^ ~b) <= ~b
define i1 @test_sle_xor(i32 %x, i32 %y) {
; CHECK-LABEL: @test_sle_xor(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp sge i32 [[TMP1]], [[Y]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %xor1 = xor i32 %y, -1
  %xor2 = xor i32 %xor1, %x
  %r = icmp sle i32 %xor2, %xor1
  ret i1 %r
}

; test ~a > (~a ^ b)
define i1 @test_sgt_xor(i32 %x, i32 %y) {
; CHECK-LABEL: @test_sgt_xor(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i32 [[Y:%.*]], [[X:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i32 [[TMP1]], [[X]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %xor1 = xor i32 %x, -1
  %xor2 = xor i32 %xor1, %y
  %cmp = icmp sgt i32 %xor2, %xor1
  ret i1 %cmp
}

define i1 @test_sge_xor(i32 %x, i32 %y) {
; CHECK-LABEL: @test_sge_xor(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i32 [[Y:%.*]], [[X:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp sle i32 [[TMP1]], [[X]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %xor1 = xor i32 %x, -1
  %xor2 = xor i32 %xor1, %y
  %cmp = icmp sge i32 %xor2, %xor1
  ret i1 %cmp
}

define i1 @test_ult_xor(i32 %x, i32 %y) {
; CHECK-LABEL: @test_ult_xor(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i32 [[Y:%.*]], [[X:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt i32 [[TMP1]], [[X]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %xor1 = xor i32 %x, -1
  %xor2 = xor i32 %xor1, %y
  %cmp = icmp ult i32 %xor2, %xor1
  ret i1 %cmp
}

define i1 @test_ule_xor(i32 %x, i32 %y) {
; CHECK-LABEL: @test_ule_xor(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i32 [[Y:%.*]], [[X:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp uge i32 [[TMP1]], [[X]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %xor1 = xor i32 %x, -1
  %xor2 = xor i32 %xor1, %y
  %cmp = icmp ule i32 %xor2, %xor1
  ret i1 %cmp
}

define i1 @test_ugt_xor(i32 %x, i32 %y) {
; CHECK-LABEL: @test_ugt_xor(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i32 [[Y:%.*]], [[X:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i32 [[TMP1]], [[X]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %xor1 = xor i32 %x, -1
  %xor2 = xor i32 %xor1, %y
  %cmp = icmp ugt i32 %xor2, %xor1
  ret i1 %cmp
}

define i1 @test_uge_xor(i32 %x, i32 %y) {
; CHECK-LABEL: @test_uge_xor(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i32 [[Y:%.*]], [[X:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp ule i32 [[TMP1]], [[X]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %xor1 = xor i32 %x, -1
  %xor2 = xor i32 %xor1, %y
  %cmp = icmp uge i32 %xor2, %xor1
  ret i1 %cmp
}

; Negative tests
define i1 @test_xor1_nofold_multi_use(i8 %x, i8 %y, i8 %z) {
; CHECK-LABEL: @test_xor1_nofold_multi_use(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i8 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[XOR2:%.*]] = xor i8 [[TMP1]], -1
; CHECK-NEXT:    call void @use.i8(i8 [[XOR2]])
; CHECK-NEXT:    [[NZ:%.*]] = xor i8 [[Z:%.*]], -1
; CHECK-NEXT:    call void @use.i8(i8 [[NZ]])
; CHECK-NEXT:    [[R:%.*]] = icmp sgt i8 [[TMP1]], [[Z]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %xor = xor i8 %x, -1
  %xor2 = xor i8 %xor, %y
  call void @use.i8(i8 %xor2)
  %nz = xor i8 %z, -1
  call void @use.i8(i8 %nz)
  %r = icmp slt i8 %xor2, %nz
  ret i1 %r
}

define i1 @xor_uge(i8 %x, i8 %y) {
; CHECK-LABEL: @xor_uge(
; CHECK-NEXT:    [[YNZ:%.*]] = icmp ne i8 [[Y:%.*]], 0
; CHECK-NEXT:    call void @llvm.assume(i1 [[YNZ]])
; CHECK-NEXT:    [[XOR:%.*]] = xor i8 [[X:%.*]], [[Y]]
; CHECK-NEXT:    [[R:%.*]] = icmp ugt i8 [[XOR]], [[X]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %ynz = icmp ne i8 %y, 0
  call void @llvm.assume(i1 %ynz)
  %xor = xor i8 %x, %y
  %r = icmp uge i8 %xor, %x
  ret i1 %r
}

define i1 @xor_uge_fail_maybe_zero(i8 %x, i8 %y) {
; CHECK-LABEL: @xor_uge_fail_maybe_zero(
; CHECK-NEXT:    [[XOR:%.*]] = xor i8 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp uge i8 [[XOR]], [[X]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %xor = xor i8 %x, %y
  %r = icmp uge i8 %xor, %x
  ret i1 %r
}

define <2 x i1> @xor_ule_2(<2 x i8> %x, <2 x i8> %yy) {
; CHECK-LABEL: @xor_ule_2(
; CHECK-NEXT:    [[Y:%.*]] = or <2 x i8> [[YY:%.*]], <i8 9, i8 8>
; CHECK-NEXT:    [[XOR:%.*]] = xor <2 x i8> [[Y]], [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp ult <2 x i8> [[XOR]], [[X]]
; CHECK-NEXT:    ret <2 x i1> [[R]]
;
  %y = or <2 x i8> %yy, <i8 9, i8 8>
  %xor = xor <2 x i8> %y, %x
  %r = icmp ule <2 x i8> %xor, %x
  ret <2 x i1> %r
}

define i1 @xor_sle_2(i8 %xx, i8 %y, i8 %z) {
; CHECK-LABEL: @xor_sle_2(
; CHECK-NEXT:    [[X:%.*]] = add i8 [[XX:%.*]], [[Z:%.*]]
; CHECK-NEXT:    [[YNZ:%.*]] = icmp ne i8 [[Y:%.*]], 0
; CHECK-NEXT:    call void @llvm.assume(i1 [[YNZ]])
; CHECK-NEXT:    [[XOR:%.*]] = xor i8 [[X]], [[Y]]
; CHECK-NEXT:    [[R:%.*]] = icmp sgt i8 [[XOR]], [[X]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %x = add i8 %xx, %z
  %ynz = icmp ne i8 %y, 0
  call void @llvm.assume(i1 %ynz)
  %xor = xor i8 %x, %y
  %r = icmp sle i8 %x, %xor
  ret i1 %r
}

define i1 @xor_sge(i8 %xx, i8 %yy) {
; CHECK-LABEL: @xor_sge(
; CHECK-NEXT:    [[X:%.*]] = mul i8 [[XX:%.*]], [[XX]]
; CHECK-NEXT:    [[Y:%.*]] = or i8 [[YY:%.*]], -128
; CHECK-NEXT:    [[XOR:%.*]] = xor i8 [[Y]], [[X]]
; CHECK-NEXT:    [[R:%.*]] = icmp slt i8 [[XOR]], [[X]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %x = mul i8 %xx, %xx
  %y = or i8 %yy, 128
  %xor = xor i8 %y, %x
  %r = icmp sge i8 %x, %xor
  ret i1 %r
}

define i1 @xor_ugt_2(i8 %xx, i8 %y, i8 %z) {
; CHECK-LABEL: @xor_ugt_2(
; CHECK-NEXT:    [[X:%.*]] = add i8 [[XX:%.*]], [[Z:%.*]]
; CHECK-NEXT:    [[YZ:%.*]] = and i8 [[Y:%.*]], 63
; CHECK-NEXT:    [[Y1:%.*]] = or disjoint i8 [[YZ]], 64
; CHECK-NEXT:    [[XOR:%.*]] = xor i8 [[X]], [[Y1]]
; CHECK-NEXT:    [[R:%.*]] = icmp ugt i8 [[X]], [[XOR]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %x = add i8 %xx, %z
  %yz = and i8 %y, 63
  %y1 = or i8 %yz, 64
  %xor = xor i8 %x, %y1
  %r = icmp ugt i8 %x, %xor
  ret i1 %r
}

define i1 @xor_ult(i8 %x) {
; CHECK-LABEL: @xor_ult(
; CHECK-NEXT:    [[XOR:%.*]] = xor i8 [[X:%.*]], 123
; CHECK-NEXT:    [[R:%.*]] = icmp ult i8 [[XOR]], [[X]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %xor = xor i8 %x, 123
  %r = icmp ult i8 %xor, %x
  ret i1 %r
}

define <2 x i1> @xor_sgt(<2 x i8> %x, <2 x i8> %y) {
; CHECK-LABEL: @xor_sgt(
; CHECK-NEXT:    [[YZ:%.*]] = and <2 x i8> [[Y:%.*]], splat (i8 31)
; CHECK-NEXT:    [[Y1:%.*]] = or disjoint <2 x i8> [[YZ]], splat (i8 64)
; CHECK-NEXT:    [[XOR:%.*]] = xor <2 x i8> [[X:%.*]], [[Y1]]
; CHECK-NEXT:    [[R:%.*]] = icmp sgt <2 x i8> [[XOR]], [[X]]
; CHECK-NEXT:    ret <2 x i1> [[R]]
;
  %yz = and <2 x i8> %y, <i8 31, i8 31>
  %y1 = or <2 x i8> %yz, <i8 64, i8 64>
  %xor = xor <2 x i8> %x, %y1
  %r = icmp sgt <2 x i8> %xor, %x
  ret <2 x i1> %r
}

define <2 x i1> @xor_sgt_fail_no_known_msb(<2 x i8> %x, <2 x i8> %y) {
; CHECK-LABEL: @xor_sgt_fail_no_known_msb(
; CHECK-NEXT:    [[YZ:%.*]] = and <2 x i8> [[Y:%.*]], splat (i8 55)
; CHECK-NEXT:    [[Y1:%.*]] = or disjoint <2 x i8> [[YZ]], splat (i8 8)
; CHECK-NEXT:    [[XOR:%.*]] = xor <2 x i8> [[X:%.*]], [[Y1]]
; CHECK-NEXT:    [[R:%.*]] = icmp sgt <2 x i8> [[XOR]], [[X]]
; CHECK-NEXT:    ret <2 x i1> [[R]]
;
  %yz = and <2 x i8> %y, <i8 63, i8 63>
  %y1 = or <2 x i8> %yz, <i8 8, i8 8>
  %xor = xor <2 x i8> %x, %y1
  %r = icmp sgt <2 x i8> %xor, %x
  ret <2 x i1> %r
}

define i1 @xor_slt_2(i8 %x, i8 %y, i8 %z) {
; CHECK-LABEL: @xor_slt_2(
; CHECK-NEXT:    [[XOR:%.*]] = xor i8 [[X:%.*]], 88
; CHECK-NEXT:    [[R:%.*]] = icmp slt i8 [[X]], [[XOR]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %xor = xor i8 %x, 88
  %r = icmp slt i8 %x, %xor
  ret i1 %r
}

define <2 x i1> @xor_sgt_intmin_2(<2 x i8> %xx, <2 x i8> %yy, <2 x i8> %z) {
; CHECK-LABEL: @xor_sgt_intmin_2(
; CHECK-NEXT:    [[X:%.*]] = add <2 x i8> [[XX:%.*]], [[Z:%.*]]
; CHECK-NEXT:    [[Y:%.*]] = or <2 x i8> [[YY:%.*]], splat (i8 -128)
; CHECK-NEXT:    [[XOR:%.*]] = xor <2 x i8> [[X]], [[Y]]
; CHECK-NEXT:    [[R:%.*]] = icmp sgt <2 x i8> [[X]], [[XOR]]
; CHECK-NEXT:    ret <2 x i1> [[R]]
;
  %x = add <2 x i8> %xx, %z
  %y = or <2 x i8> %yy, <i8 128, i8 128>
  %xor = xor <2 x i8> %x, %y
  %r = icmp sgt <2 x i8> %x, %xor
  ret <2 x i1> %r
}

define i1 @or_slt_intmin_indirect(i8 %x, i8 %C) {
; CHECK-LABEL: @or_slt_intmin_indirect(
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i8 [[C:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP]], label [[NEG:%.*]], label [[POS:%.*]]
; CHECK:       common.ret:
; CHECK-NEXT:    [[COMMON_RET_OP:%.*]] = phi i1 [ [[R:%.*]], [[NEG]] ], [ false, [[POS]] ]
; CHECK-NEXT:    ret i1 [[COMMON_RET_OP]]
; CHECK:       neg:
; CHECK-NEXT:    [[XOR:%.*]] = xor i8 [[C]], [[X:%.*]]
; CHECK-NEXT:    [[R]] = icmp slt i8 [[XOR]], [[X]]
; CHECK-NEXT:    br label [[COMMON_RET:%.*]]
; CHECK:       pos:
; CHECK-NEXT:    tail call void @barrier()
; CHECK-NEXT:    br label [[COMMON_RET]]
;
  %cmp = icmp slt i8 %C, 0
  br i1 %cmp, label %neg, label %pos
common.ret:
  %common.ret.op = phi i1 [ %r, %neg ], [ false, %pos ]
  ret i1 %common.ret.op
neg:
  %xor = xor i8 %C, %x
  %r = icmp slt i8 %xor, %x
  br label %common.ret
pos:
  tail call void @barrier()
  br label %common.ret
}
