-- 1. Contare quanti iscritti ci sono stati ogni anno
SELECT COUNT(`id`) as "Numero di iscritti",
    YEAR(`enrolment_date`) as "Anno di iscrizione"
FROM `students`
GROUP BY YEAR(`enrolment_date`);

-- 2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio
SELECT COUNT(`id`) as "Numero di insegnati",
    `office_number` as "Ufficio"
FROM `teachers`
GROUP BY `office_number`;

-- 3. Calcolare la media dei voti di ogni appello d'esame
SELECT `exam_id` as "Appello",
    FLOOR(AVG(`vote`)) as "Media dei Voti"
FROM `exam_student`
GROUP BY `exam_id`;

-- 4. Contare quanti corsi di laurea ci sono per ogni dipartimento
SELECT COUNT(`id`) as "Numero di corsi", `department_id` as "Numero del dipartimento"
FROM `degrees`
GROUP BY `department_id`;