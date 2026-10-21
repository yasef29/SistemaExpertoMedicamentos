
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_files)).
:- use_module(library(http/http_parameters)).
:- use_module(library(lists)).

% Cargar la base de conocimiento desde la carpeta prolog
:- prolog_load_context(directory, PrologDir),
   directory_file_path(PrologDir, 'conocimiento.pl', KnowledgeFile),
   consult(KnowledgeFile).

% Obtener la carpeta web del proyecto
:- prolog_load_context(directory, PrologDir),
   directory_file_path(PrologDir, '..', ProjectDir0),
   absolute_file_name(ProjectDir0, ProjectDir),
   directory_file_path(ProjectDir, 'web', WebDir),
   absolute_file_name(WebDir, WebDirectory),
   http_handler(root(.),
       http_reply_from_files(WebDirectory, []),
       [prefix]).

% Ruta de la API
:- http_handler(root(api/consultar), consultar_api, []).

% Recibir el medicamento y obtener TODAS las recomendaciones
consultar_api(Request) :-
    http_parameters(Request,
        [medicamento(Medicamento, [atom])]),
    format('Content-type: text/plain; charset=UTF-8~n~n'),
    format('Medicamento consultado: ~w~n~n', [Medicamento]),
    findall(
        Recomendacion,
        recomendacion(Medicamento, Recomendacion),
        ListaOriginal
    ),
    sort(ListaOriginal, Recomendaciones),
    (   Recomendaciones = []
    ->  format(
            'No hay una recomendacion registrada para: ~w~n',
            [Medicamento]
        )
    ;   format('Recomendaciones del sistema experto:~n~n', []),
        maplist(mostrar_recomendacion, Recomendaciones)
    ).

% Mostrar cada recomendacion en lenguaje sencillo
mostrar_recomendacion(consultar_farmacia) :-
    format(
        '- Consulta en una farmacia la disponibilidad del medicamento.~n',
        []
    ).

mostrar_recomendacion(contactar_unidad_medica) :-
    format(
        '- Contacta a tu unidad medica para conocer las opciones disponibles.~n',
        []
    ).

mostrar_recomendacion(consultar_profesional_salud) :-
    format(
        '- Consulta a un profesional de salud antes de realizar cualquier sustitucion.~n',
        []
    ).

mostrar_recomendacion(verificar_disponibilidad) :-
    format(
        '- La disponibilidad no esta confirmada. Verifica directamente con una farmacia o unidad medica.~n',
        []
    ).

mostrar_recomendacion(confirmar_existencia) :-
    format(
        '- Los datos de ejemplo registran el medicamento como disponible. Confirma su existencia directamente.~n',
        []
    ).


% Iniciar el servidor compatible con Render

main :-
    ( getenv('PORT', PortAtom),
      atom_number(PortAtom, Port)
    -> true
    ;  Port = 8080
    ),
    http_server(
        http_dispatch,
        [port(Port), ip('0.0.0.0')]
    ),
    format('Servidor iniciado en el puerto ~w~n', [Port]),
    thread_get_message(_).

:- initialization(main, main).
