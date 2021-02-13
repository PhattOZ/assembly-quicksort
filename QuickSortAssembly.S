				;		Initialization
				
initialList		DCD		19, 5, 10, 2, 3, 6, 13, 17, 333, 1	; Initialize an array
				LDR		R0, =initialList		; Assign the array location to R0
				MOV		R1, #10				; Assign R1 a size of the array
				
				;		Algorithm
				
qsort			CMP		LR, #0
				MOVNE	R3, #1
				STRNE	LR, [SP, #-4]!
				STR		R0,[SP, #-4]!			; Push all registers on to the stack
				STR		R1,[SP, #-4]!
				STR		R2,[SP, #-4]!
				STR		R3,[SP, #-4]!
				STR		R4,[SP, #-4]!
				STR		R5,[SP, #-4]!
				STR		R6,[SP, #-4]!
				STR		R7,[SP, #-4]!
				STR		R8,[SP, #-4]!
				STR		R9,[SP, #-4]!
				STR		R10,[SP, #-4]!
				
				MOV		R4, R0				; R4 = Array location
				MOV		R5, R1				; R5 = Array size
				CMP		R5, #1				; IF There's only one element or less
				BLE		qsort_return			; Terminate
				CMP		R5, #2
				BEQ		qsort_check
				SUB		R8, R5, #1			; In this lab we use last element as pivot
				LDR		R9, [R4, R8, LSL #2]	; R9 = Pivot, R8 = Last element's index
				MOV		R6, #-1				; Our "i" = -1
				MOV		R7, #0				; Our "j" = 0
				
qsort_loop		LDR		R0, [R4, R7, LSL #2]	; Until "j" reach the end of array
				CMP		R0, R9				; Compare arr[j] with the pivot
				BLLE		increment_and_swap		; If arr[j] < pivot
				ADD		R7, R7, #1			; Increment "j"
				CMP		R7, R8
				BNE		qsort_loop
				BEQ		qsort_partition		; When "j" reach the end do partition
				
increment_and_swap	ADD		R6, R6, #1			; Increment "i"
				LDR		R0, [R4, R6, LSL #2]	; Swap arr[i] and arr[j]
				LDR		R1, [R4, R7, LSL #2]
				STR		R0, [R4, R7, LSL #2]
				STR		R1, [R4, R6, LSL #2]
				MOV		PC, LR
				
qsort_partition	ADD		R6, R6, #1			; i = i + 1
				LDR		R0, [R4, R6, LSL #2]	; Swap arr[i+1] with pivot
				MOV		R1, R9
				STR		R0, [R4, R8, LSL #2]
				STR		R1, [R4, R6, LSL #2]
				
				MOV		R0, R4				; First index of the left side
				MOV		R1, R6				; Length of the first side
				BL		qsort
				ADD		R6, R6, #1
				CMP		R6, R5
				BGE		qsort_return
				ADD		R0, R4, R6, LSL #2
				SUB		R1, R5, R6
				BL		qsort
				B		qsort_return
				
qsort_check		LDR		R0,[R4]
				LDR		R1,[R4,#4]
				CMP		R0,R1
				BLE		qsort_return
				STR		R1,[R4]
				STR		R0,[R4,#4]
				
qsort_return		LDR		R10,[SP], #4			; Pop all registers off the stack
				LDR		R9,[SP], #4
				LDR		R8,[SP], #4
				LDR		R7,[SP], #4
				LDR		R6,[SP], #4
				LDR		R5,[SP], #4
				LDR		R4,[SP], #4
				LDR		R3,[SP], #4
				LDR		R2,[SP], #4
				LDR		R1,[SP], #4
				LDR		R0,[SP], #4
				CMP		R3, #1
				LDREQ	PC,[SP], #4
