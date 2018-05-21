capitalRegional("Arica", "$32.200 pesos").
capitalRegional("Iquique", "$30.100 pesos").
capitalRegional("Antofagasta", "$21.600 pesos").
capitalRegional("Copiapó", "$15.000 pesos").
capitalRegional("La Serena", "$9.100 pesos").
capitalRegional("Valparaíso", "$6.500 pesos").
capitalRegional("Rancagua", "$3.000 pesos").
capitalRegional("Talca", "$6.500 pesos").
capitalRegional("Concepción", "$13.900 pesos").
capitalRegional("Temuco", "$14.900 pesos").
capitalRegional("Puerto Montt", "$19.900 pesos").
capitalRegional("Coyhaique", "$33.000 pesos").
capitalRegional("Punta Arenas", "$15.000 pesos").
capitalRegional("Valdivia", "$17.900 pesos").

listadoCapitales(["Arica", "Iquique", "Antofagasta", "Copiapó", "La Serena", "Valparaíso", "Rancagua", "Talca", "Concepción", "Temuco", "Puerto Montt", "Coyhaique", "Punta Arenas", "Valdivia"]).

afirmacion("Sí").
afirmacion("sí").
afirmacion("Si").
afirmacion("si").
afirmacion("Sí.").
afirmacion("sí.").
afirmacion("Si.").
afirmacion("si.").

user1(["Gabriel", "Me gustaría tomar un viaje hacia La Serena", "No, mejor no, prefiero viajar a Valparaíso", "Sí"]).
user2(["Diego", "Me gustaría viajar hacia Punta Arenas", "Sí"]).
user3(["Paloma", "Tengo unas ganas de visitar a mi familia en Arica", "no", "Prefiero viajar a Valdivia primero", "Sí"]).

negacion("No").
negacion("no").
negacion("No.").
negacion("no.").

head([Head|_], Head).

tails([_|Tails], Tails).

compareList([Head|Tails], [Head|Tails]).

chatbot( [
		 ["Hola, mi nombre es Bot, y estoy aquí para ayudarlo a seleccionar un destino. ¿Me podría decir su nombre?", "Hola, mi nombre es Bot, y si quieres viajar, conmigo debes hablar. ¿Cómo debo llamarte?"], 
		 [" cuéntame, ¿a dónde quieres viajar? Recuerda que por el momento sólo ofrecemos viajes a capitales regionales del país.", " ¿a qué capital regional deseas viajar? Puedes hacerlo a cualquier región de Chile. Yo te recomiendo el norte.", " y bueno, ¿a qué capital regional te gustaría ir? El sur es hermoso en toda época del año."],
		 [["0", "0"]],
		 ["¿A qué ciudad entonces te gustaría ir?", "No hay problema, puedes elegir un nuevo destino"],
		 ["¡Perfecto! Ahora, para confirmar pasajes, debe ingresar a nuestro sitio web.", "Bien, ahora para confirmar la cantidad y la fecha de los pasajes, debe ingresar a nuestro sitio web"],
		 [" es un lugar precioso! Los pasajes hacia allá cuestan ", " es ideal en esta época del año, no te arrepentirás. Viajar hacia allá cuesta "],
		 ["Disculpa, no he logrado entenderte del todo... ¿podrías ser un poco más claro?", "Perdón, pero no he entendido lo que me has dicho... ¿podrías ser un poco más claro?"],
		 ["Hasta luego, espero haber sido de ayuda en esta oportunidad.", "Hasta la próxima, espero haberte ayudado."]
		 ]
		).