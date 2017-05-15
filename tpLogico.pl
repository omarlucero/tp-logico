esPropiedad(tinsmithCircle1774).
esPropiedad(avMoreno708).
esPropiedad(avSiempreViva742).
esPropiedad(calleFalsa123).

ambientes(tinsmithCircle1774, 3).
ambientes(avMoreno708, 7).
ambientes(avSiempreViva742, 4).
ambientes(calleFalsa123, 3).

cuesta(tinsmithCircle1774, 700).
cuesta(avMoreno708, 2000).
cuesta(avSiempreViva742, 1000).
cuesta(calleFalsa123, 200).

tieneJardin(tinsmithCircle1774).
tieneJardin(avMoreno708).
tieneJardin(avSiempreViva742).

tienePiscina(avMoreno708, 30).

igualCantidadDeAmbientes(Propiedad1, Propiedad2) :-
  esPropiedad(Propiedad1),
  esPropiedad(Propiedad2),
  Propiedad1 \= Propiedad2,
  ambientes(Propiedad1, Cantidad1),
  ambientes(Propiedad2, Cantidad2),
  Cantidad1 = Cantidad2.









/*consultas:
?- tienePiscina(Propiedad, 30).
Propiedad = avMoreno708

?- igualCantidadDeAmbientes(Propiedad1, Propiedad2).
Propiedad1 = tinsmithCircle1774,
Propiedad2 = calleFalsa123 ;
Propiedad1 = calleFalsa123,
Propiedad2 = tinsmithCircle1774 ;
*/
