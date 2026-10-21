
% ==========================================
% SISTEMA EXPERTO DE MEDICAMENTOS EN CDMX
% BASE DE CONOCIMIENTO
% ==========================================

% 1. Medicamentos registrados
medicamento(aspirina).
medicamento(paracetamol).
medicamento(ibuprofeno).
medicamento(metformina).
medicamento(insulina).

% 2. Disponibilidad registrada en el ejemplo
disponibilidad(aspirina, no_disponible).
disponibilidad(paracetamol, disponible).
disponibilidad(ibuprofeno, no_disponible).
disponibilidad(metformina, desconocida).
disponibilidad(insulina, no_disponible).

% 3. Tipo de medicamento
tipo(aspirina, venta_libre).
tipo(paracetamol, venta_libre).
tipo(ibuprofeno, venta_libre).
tipo(metformina, requiere_receta).
tipo(insulina, requiere_receta).

% 4. Orientaciones generales
orientacion(consultar_farmacia).
orientacion(contactar_unidad_medica).
orientacion(acudir_a_urgencias).
orientacion(consultar_profesional_salud).
orientacion(verificar_disponibilidad).


% ==========================================
% REGLAS DEL SISTEMA EXPERTO
% ==========================================

% 1. Identifica medicamentos sin disponibilidad
medicamento_sin_existencia(M) :-
    medicamento(M),
    disponibilidad(M, no_disponible).

% 2. Identifica medicamentos cuya disponibilidad se desconoce
disponibilidad_pendiente(M) :-
    medicamento(M),
    disponibilidad(M, desconocida).

% 3. Identifica medicamentos registrados como disponibles
medicamento_disponible(M) :-
    medicamento(M),
    disponibilidad(M, disponible).

% 4. Identifica medicamentos que requieren receta
requiere_atencion_profesional(M) :-
    medicamento(M),
    tipo(M, requiere_receta).

% 5. Comprueba que una orientación esté registrada
orientacion_valida(O) :-
    orientacion(O).

% 6. Recomienda verificar cuando no se conoce la disponibilidad
recomendacion(M, verificar_disponibilidad) :-
    disponibilidad_pendiente(M).

% 7. Recomienda consultar una farmacia si falta uno de venta libre
recomendacion(M, consultar_farmacia) :-
    medicamento_sin_existencia(M),
    tipo(M, venta_libre).

% 8. Recomienda contactar una unidad medica si falta uno con receta
recomendacion(M, contactar_unidad_medica) :-
    medicamento_sin_existencia(M),
    requiere_atencion_profesional(M).

% 9. Recomienda orientación profesional antes de sustituir uno con receta
recomendacion(M, consultar_profesional_salud) :-
    medicamento_sin_existencia(M),
    requiere_atencion_profesional(M).

% 10. Recomienda confirmar la existencia de un medicamento disponible
recomendacion(M, confirmar_existencia) :-
    medicamento_disponible(M).


% ==========================================
% CASOS DE PRUEBA DEL SISTEMA EXPERTO
% ==========================================

% Prueba 1: aspirina registrada
prueba(1, medicamento(aspirina)).

% Prueba 2: paracetamol registrado
prueba(2, medicamento(paracetamol)).

% Prueba 3: ibuprofeno registrado
prueba(3, medicamento(ibuprofeno)).

% Prueba 4: metformina registrada
prueba(4, medicamento(metformina)).

% Prueba 5: insulina registrada
prueba(5, medicamento(insulina)).

% Prueba 6: aspirina sin existencia registrada
prueba(6, medicamento_sin_existencia(aspirina)).

% Prueba 7: paracetamol disponible en los datos
prueba(7, medicamento_disponible(paracetamol)).

% Prueba 8: disponibilidad desconocida de metformina
prueba(8, disponibilidad_pendiente(metformina)).

% Prueba 9: insulina requiere atencion profesional
prueba(9, requiere_atencion_profesional(insulina)).

% Prueba 10: orientacion de farmacia registrada
prueba(10, orientacion_valida(consultar_farmacia)).
