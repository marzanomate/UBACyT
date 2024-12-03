gen lnpbi = ln(Y)

gen lnT = ln(T)

gen lnG = ln(G)

**** Modelo pbi = a_o + b_1 * G + c_2 * T + e_1

reg Y G T

hettest

**** Modelo T = a_1 + b_2 * Y + e_2

reg T Y

hettest

**** Modelo G = a_2 + b_3 * Y + e_3

reg G Y

hettest

graph twoway (lfit G Y) (scatter G Y)

**** Ningun modelo tiene heterocedasticidad





