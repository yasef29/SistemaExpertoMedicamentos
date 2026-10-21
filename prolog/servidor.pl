
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_files)).
:- use_module(library(http/http_parameters)).

% Cargar la base de conocimiento
:- consult('C:/Users/cyase/OneDrive/Documents/SistemaExpertoMedicamentos/prolog/conocimiento.pl').

% Direccion de la API
:- http_handler(root(api/consultar), consultar_api, []).

% Mostrar la pagina web
:- http_handler(root(.),
    http_reply_from_files(
        'C:/Users/cyase/OneDrive/Documents/SistemaExpertoMedicamentos/web',
        []
    ),
    [prefix]).

% Recibir la consulta del navegador y buscar una recomendacion
consultar_api(Request) :-
    http_parameters(Request,
        [medicamento(Medicamento, [atom])]
    ),
    format('Content-type: text/plain; charset=UTF-8~n~n'),
    (   once(recomendacion(Medicamento, Recomendacion))
    ->  format('Medicamento consultado: ~w~n~n', [Medicamento]),
        mostrar_recomendacion(Recomendacion)
    ;   format('No hay una recomendacion registrada para: ~w~n',
               [Medicamento])
    ).

% Explicar las recomendaciones en lenguaje sencillo
mostrar_recomendacion(consultar_farmacia) :-
    format('Orientacion: Consulta en una farmacia la disponibilidad del medicamento.~n').

mostrar_recomendacion(contactar_unidad_medica) :-
    format('Orientacion: Contacta a tu unidad medica para conocer las opciones disponibles.~n').

mostrar_recomendacion(consultar_profesional_salud) :-
    format('Orientacion: Consulta a un profesional de salud antes de realizar cualquier sustitucion.~n').

mostrar_recomendacion(verificar_disponibilidad) :-
    format('Orientacion: La disponibilidad no esta confirmada. Verifica directamente con una farmacia o unidad medica.~n').

mostrar_recomendacion(confirmar_existencia) :-
    format('Orientacion: La base de datos registra el medicamento como disponible, pero debes confirmar su existencia directamente.~n').

% Iniciar el servidor
main :-
    http_server(http_dispatch, [port(8080)]),
    format('Servidor iniciado en http://localhost:8080/~n', []),
    thread_get_message(_).

:- initialization(main, main).
