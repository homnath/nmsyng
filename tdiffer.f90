      subroutine tdiffer(iy1,jd1,ih1,im1,fs1,iy2,jd2,ih2,im2,fs2,secs)
!
      integer iy1,jd1,ih1,im1,iy2,jd2,ih2,im2
      real fs1,fs2
      double precision secs
!
      integer i,imin,jdif
!
      if(iy1.eq.0.and.iy2.eq.0) then
        write(6,"( 'diff. of indeterminate times in tdiffer')")
        call exit(1)
      endif
      imin=0
      if(iy1.eq.0) then
        secs=1.d12
      else if(iy2.eq.0) then
        secs=-1.d12
      else
        jdif=0
        if(iy1.ne.iy2) then
          do 101 i=min0(iy1,iy2),max0(iy1,iy2)-1
        if(mod(i,4).eq.0.and.(mod(i,100).ne.0.or.mod(i,400).eq.0))then
              jdif=jdif+366
            else
              jdif=jdif+365
            endif
  101     continue
          if(iy1.lt.iy2) jdif=-jdif
        endif
        secs=fs1-fs2+60.d0*(float(im1-im2)+60.d0*(float(ih1-ih2)+24.d0*float(jdif+jd1-jd2)))
      endif
      return
      end
