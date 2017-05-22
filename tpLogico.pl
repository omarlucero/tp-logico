cuesta(tinsmithCircle1774, 700).
cuesta(avMoreno708, 2000).
cuesta(avSiempreViva742, 1000).
cuesta(calleFalsa123, 200).

esPropiedad(UnaPropiedad):- cuesta(UnaPropiedad, _).

tiene(tinsmithCircle1774, ambientes(3)).
tiene(tinsmithCircle1774, jardin).

tiene(avMoreno708, ambientes(7)).
tiene(avMoreno708, piscina(30)).
tiene(avMoreno708, jardin).

tiene(avSiempreViva742, ambientes(4)).
tiene(avSiempreViva742, jardin).

tiene(calleFalsa123, ambientes(3)).

persona(carlos).
persona(ana).
persona(maria).
persona(pedro).
persona(chameleon).

loQueQuiere(carlos, jardin).
loQueQuiere(carlos, ambientes(3)).

loQueQuiere(ana, piscina(100)).

loQueQuiere(maria, ambientes(2)).
loQueQuiere(maria, piscina(15)).

loQueQuiere(pedro, Comodidad):- loQueQuiere(maria, Comodidad).

loQueQuiere(chameleon, Comodidad):- persona(Cliente), Cliente \= chameleon, loQueQuiere(Cliente, Comodidad).

cumpleCondicion(Propiedad, Comodidad):-
  esPropiedad(Propiedad),
  loQueQuiere(_, Comodidad),
  tiene(Propiedad, Comodidad).

cumpleCondicion(Propiedad, ambientes(AmbientesDeseados)):-
  esPropiedad(Propiedad),
  loQueQuiere(_, ambientes(AmbientesDeseados)),
  tiene(Propiedad, ambientes(AmbientesDePropiedad)),
  AmbientesDePropiedad >= AmbientesDeseados.

cumpleCondicion(Propiedad, piscina(MetrosDeseados)):-
 esPropiedad(Propiedad),
 loQueQuiere(_, piscina(MetrosDeseados)),
 tiene(Propiedad, piscina(MetrosDePiscinaReales)),
 MetrosDePiscinaReales >= MetrosDeseados.


/*consultas:
?- tiene(Propiedad, piscina(30)).
Propiedad = avMoreno708.

?- tiene(Propiedad1, ambientes(Cantidad)), tiene(Propiedad2, ambientes(Cantidad)), Propiedad1 \= Propiedad2.
Propiedad1 = tinsmithCircle1774,
Cantidad = 3,
Propiedad2 = calleFalsa123 ;

?- loQueQuiere(pedro, Comodidad).
Comodidad = ambientes(2) ;
Comodidad = piscina(15).

?- cumpleCodicion(Propiedad, ambientes(2)).
Propiedad = tinsmithCircle1774 ;
Propiedad = avMoreno708 ;
Propiedad = avSiempreViva742 ;
Propiedad = calleFalsa123

?- tiene(Propiedad, Comodidad), loQueQuiere(pedro, Comodidad).
false.

?- tiene(avMoreno708, Comodidad), loQueQuiere(_, Comodidad).
Comodidad = jardin ;

?-  loQueQuiere(_, Comodidad), not(cumpleCondicion(_, Comodidad)).
Comodidad = piscina(100)
*/
