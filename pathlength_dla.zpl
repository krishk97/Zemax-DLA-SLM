! pathlength.zpl

input "Enter chirp in mm/nm:", chirp

! determine what surface number grating is 
surf_start = 0
FOR j=0, NSUR(), 1
	IF (j != 100 & STYP(j)==17)
			surf_start = j
			GOTO label1
	ENDIF
NEXT
LABEL label1
		
! Calculate central ray pathlength using central wavelength
RAYTRACE 0, 0, 0, 0, 1	
yc = RAYY(NSUR())
pl0 = 0
FOR j = surf_start, NSUR(), 1
	IF j != 100
		pl0 = RAYO(j) + pl0
	ENDIF
NEXT	

numsteps = 100

FOR k = 1, NWAV(), 1
	FOR i = 0, numsteps, 1
		py = i * 2 / numsteps - 1
		RAYTRACE 0, 0, 0, py, k
		yf = RAYY(NSUR())
		pl = 0
		FOR j = surf_start, NSUR(), 1
        		IF j != 100
				pl = RAYO(j) + pl
			ENDIF
		NEXT	
	Print yf-yc,"	",(pl+(k-1)*chirp-pl0)/0.3,"	",k
	NEXT
NEXT