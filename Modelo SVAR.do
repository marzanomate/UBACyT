
set obs 73

gen date2 = yq(2004,1) + _n-1

format date2 %tq

rename date2 date

drop date

tsset date

gen ln_expreal = ln(exp_real)

gen ln_taxreal = ln(tax_real)

gen ln_gdpreal = ln(gdp_real)

dfuller ln_expreal

dfuller ln_taxreal

dfuller ln_gdpreal

**** No hay raices unitarias

varsoc ln_gdpreal ln_expreal ln_taxreal, maxlag(12)

*** Utilizamos un rezagos de la variable por criterio SBIC, el criterio nos indica cuatro rezagos

var ln_gdpreal ln_taxreal ln_expreal, lags(1/2)

varlmar

*** No rechazamos H0 al 0.01, con lo cual podemos decir que no hay autocorrelacion con el error

vargranger

***Observamos dos cosas: 1) La variacion de la recaudacion no tiene efectos sobre la variacion del producto; 2) La variacion de la recaudacion no provoca una variacion del gasto

constraint define 1 [ln_gdpreal]L1.ln_taxreal=0

constraint define 2 [ln_gdpreal]L2.ln_taxreal=0

constraint define 3 [ln_gdpreal]L2.ln_gdpreal=0

constraint define 4 [ln_taxreal]L2.ln_taxreal=0

constraint define 5 [ln_expreal]L1.ln_expreal=0

var ln_gdpreal ln_taxreal ln_expreal, lags(1/2) constraints(1/5)

varstable, graph

*** Hay estabilidad y, por ende, estacionariedad

irf create oirf, step(20) bs rep(100) set(irf, replace)

irf graph irf, impulse(ln_taxreal) response(ln_gdpreal ln_expreal ln_taxreal)

irf graph irf, impulse(ln_expreal) response(ln_gdpreal)

irf table irf, impulse(ln_taxreal) response(ln_gdpreal)

irf table irf, impulse(ln_expreal) response(ln_gdpreal)

varbasic ln_gdpreal ln_taxreal ln_expreal, lags(1/2) 

irf graph oirf, impulse(ln_taxreal) response(ln_gdpreal ln_expreal ln_taxreal)

*** 1) Un incremento de la recaudacion en el momento 0, provoca luego una caida de la misma;2) Efectos casi nulos en el gasto y gdp, tal como lo supusimos en nuestro modelo. 

irf graph oirf, impulse(ln_expreal) response(ln_gdpreal ln_expreal ln_taxreal)

*** 1) Impulso del gasto no modifica el producto de forma significativa.

irf graph oirf, impulse(dln_gdp) response(dln_gdp dln_exp dln_tax)

irf table oirf, impulse(dln_tax) response(dln_gdp dln_tax dln_exp)

irf table oirf, impulse(dln_exp) response(dln_gdp)

irf table fevd, noci

***Quiero evaluar los shocks del gasto directamente al pbi

varsoc dln_gdp dln_exp, exog(dln_tax) maxlag(4)

var dln_gdp dln_exp, exog(dln_tax) lags(1/4)

varstable, graph

irf create oirf_1, step(20) bs rep(100) set(oirf_1, replace)

irf graph oirf, impulse(dln_exp) response(dln_gdp)

irf graph irf, impulse(dln_exp) response(dln_gdp)

***1) Un incremento del gasto provoca inestabilidad en el producto. Podemos ver en el incremento del gasto publico una mayor inestabilidad.

varbasic dln_gdp dln_exp, step (20) lags(1/4)

***Evaluo los shocks impositivos directamente al pbi

varsoc dln_gdp dln_tax, exog(dln_exp) maxlag(10)

var dln_gdp dln_tax, exog(dln_exp) lags(1/1)

varstable, graph

irf create oirf_2, step(20) bs rep(100) set(oirf_2, replace)

irf graph oirf, impulse(dln_tax) response(dln_gdp)

varbasic ln_gdp ln_tax, step (20) lags(1/1)

*** Los efectos de una variacion en la recaudacion son mas estables. 1) Reduccion del producto; 2) Reduccion de la recaudacion futura


























