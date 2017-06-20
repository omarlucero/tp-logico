cuesta(tinsmithCircle1774, 700).
cuesta(avMoreno708, 2000).
cuesta(avSiempreViva742, 1000).
cuesta(calleFalsa123, 200).

esPropiedad(UnaPropiedad):- cuesta(UnaPropiedad, _).

tiene(tinsmithCircle1774, ambientes(3)).
tiene(tinsmithCircle1774, jardin).
tiene(tinsmithCircle1774, instalaciones([extractorDeAire, aireAcondicionado, calefaccionAGas])).

tiene(avMoreno708, ambientes(7)).
tiene(avMoreno708, piscina(30)).
tiene(avMoreno708, jardin).
tiene(avMoreno708, instalaciones([aireAcondicionado, extractorDeAire, calefaccionPorLozaRadiante, vidriosDobles])).

tiene(avSiempreViva742, ambientes(4)).
tiene(avSiempreViva742, jardin).
tiene(avSiempreViva742, instalaciones([calefaccionAGas])).

tiene(calleFalsa123, ambientes(3)).

persona(carlos).
persona(ana).
persona(maria).
persona(pedro).
persona(chameleon).

loQueQuiere(carlos, jardin).
loQueQuiere(carlos, ambientes(3)).

loQueQuiere(ana, piscina(100)).
loQueQuiere(ana, instalaciones([aireAcondicionado, vidriosDobles])).

loQueQuiere(maria, ambientes(2)).
loQueQuiere(maria, piscina(15)).

loQueQuiere(pedro, Comodidad):- loQueQuiere(maria, Comodidad).
loQueQuiere(pedro, instalaciones([vidriosDobles, calefaccionPorLozaRadiante])).

loQueQuiere(chameleon, Comodidad):- persona(Cliente), Cliente \= chameleon, loQueQuiere(Cliente, Comodidad).

cumpleCondicion(Propiedad, Comodidad):-
  loQueQuiere(_, Comodidad),
  tiene(Propiedad, Comodidad).

cumpleCondicion(Propiedad, ambientes(AmbientesDeseados)):-
  loQueQuiere(_, ambientes(AmbientesDeseados)),
  tiene(Propiedad, ambientes(AmbientesDePropiedad)),
  AmbientesDePropiedad >= AmbientesDeseados.

cumpleCondicion(Propiedad, piscina(MetrosDeseados)):-
 loQueQuiere(_, piscina(MetrosDeseados)),
 tiene(Propiedad, piscina(MetrosDePiscinaReales)),
 MetrosDePiscinaReales >= MetrosDeseados.

comodidadIncumplida(Comodidad):- loQueQuiere(_, Comodidad), not(cumpleCondicion(_, Comodidad)).

/*parte 2 */

cumpleTodo(Propiedad, Persona):-
  persona(Persona),
  esPropiedad(Propiedad),
  forall(loQueQuiere(Persona, Comodidad), cumpleCondicion(Propiedad, Comodidad)).

mejorOpcionVersionConForall(Persona, PropiedadMasBarata):-
  persona(Persona),
  cumpleTodo(PropiedadMasBarata, Persona),
  cuesta(PropiedadMasBarata, PrecioMasBarato),
  forall(cumpleTodo(OtraPropiedad, Persona), (cuesta(OtraPropiedad, PrecioMasCaro), PrecioMasCaro >= PrecioMasBarato)).

mejorOpcionVersionConNot(Persona, PropiedadMasBarata):-
  persona(Persona),
  cumpleTodo(PropiedadMasBarata, Persona),
  cuesta(PropiedadMasBarata, PrecioMasBarato),
  not((cumpleTodo(PropiedadMasCara, Persona), cuesta(PropiedadMasCara, PrecioMasCaro), PrecioMasCaro < PrecioMasBarato)).

efectividad(Puntaje):-
  personasSatisfechas(PersonasSatisfechas),
  length(PersonasSatisfechas, Cantidad),
  totalDePersonas(CantidadDePersonas),
  Puntaje is Cantidad / CantidadDePersonas.

totalDePersonas(CantidadDePersonas):-
  findall(Persona, persona(Persona), TotalDePersonas),
  length(TotalDePersonas, CantidadDePersonas).

personasSatisfechas(PersonasSatisfechasSinRepetidos):-
  findall(Persona, (esPropiedad(Propiedad), cumpleTodo(Propiedad, Persona)), PersonasSatisfechasRepetidas),
  list_to_set(PersonasSatisfechasRepetidas, PersonasSatisfechasSinRepetidos).

propiedadTop(Propiedad):-
  esPropiedad(Propiedad),
  not(esChica(Propiedad)),
  cumpleCondicion(Propiedad, instalaciones([aireAcondicionado])).

esChica(Propiedad) :- tiene(Propiedad, ambientes(1)).
esChica(Propiedad) :- esPropiedad(Propiedad), not(tiene(Propiedad, ambientes(_))).

cumpleCondicion(Propiedad, instalaciones(InstalacionesDeseadas)) :-
  esPropiedad(Propiedad),
  tiene(Propiedad, instalaciones(InstalacionesDeLaPropiedad)),
  forall(member(Instalacion, InstalacionesDeseadas), member(Instalacion, InstalacionesDeLaPropiedad)).

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

?- cumpleCodicion(_, ambientes(2)).
Propiedad = tinsmithCircle1774 ;
Propiedad = avMoreno708 ;
Propiedad = avSiempreViva742 ;
Propiedad = calleFalsa123

?- tiene(Propiedad, Comodidad), loQueQuiere(pedro, Comodidad).
false.

?- cumpleCondicion(avMoreno708, Comodidad).
Comodidad = jardin ;
Comodidad = jardin ;
Comodidad = ambientes(3) ;
Comodidad = ambientes(2) ;
Comodidad = ambientes(2) ;
Comodidad = ambientes(3) ;
Comodidad = ambientes(2) ;
Comodidad = ambientes(2) ;
Comodidad = piscina(15) ;
Comodidad = piscina(15) ;
Comodidad = piscina(15) ;
Comodidad = piscina(15) ;

?- comodidadIncumplida(Comodidad).
Comodidad = piscina(100) ;
Comodidad = piscina(100) ;

consultas de la parte 2

?- cumpleTodo(Propiedad, Persona).
Propiedad = tinsmithCircle1774,
Persona = carlos ;
Propiedad = avMoreno708,
Persona = carlos ;
Propiedad = avSiempreViva742,
Persona = carlos ;
Propiedad = avMoreno708,
Persona = maria ;
Propiedad = avMoreno708,
Persona = pedro ;

?- mejorOpcionVersionConForall(Persona, PropiedadMasBarata).
Persona = carlos,
PropiedadMasBarata = tinsmithCircle1774 ;
Persona = maria,
PropiedadMasBarata = avMoreno708 ;
Persona = pedro,
PropiedadMasBarata = avMoreno708 ;

?- mejorOpcionVersionConNot(Persona, PropiedadMasBarata).
Persona = carlos,
PropiedadMasBarata = tinsmithCircle1774 ;
Persona = maria,
PropiedadMasBarata = avMoreno708 ;
Persona = pedro,
PropiedadMasBarata = avMoreno708 ;

?- efectividad(Puntaje).
Puntaje = 0.6.

?- propiedadTop(Propiedad).
Propiedad = tinsmithCircle1774 ;
Propiedad = avMoreno708

el concepto que utilice para agregar las instalaciones a la base de conocimiento
fue el polimorfismo, el cual me permitio que en el predicado "cumpleCondicion", que
es el que utiliza las comodidades de las propiedades, los trate de la misma manera
a los functores, que son unidades compuestas, de las que no lo son.
*/
