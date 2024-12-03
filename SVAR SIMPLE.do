tsset date

matrix A = (1,0,0\.,1,0\.,.,1)
matrix B = (.,0,0\0,.,0\0,0,.)

svar   ln_gdpreal ln_taxreal ln_expreal, aeq(A) beq(B)

matrix Aest = e(A)
matrix Best = e(B)
matrix chol_est = inv(Aest)*Best

matrix list chol_est
 
irf create oirf, step(20) bs rep(100) set(irf, replace)
 
irf graph oirf, impulse(ln_taxreal) response(ln_gdpreal ln_expreal ln_taxreal)
 
irf graph oirf, impulse(ln_expreal) response(ln_gdpreal ln_expreal ln_taxreal)




