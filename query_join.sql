-- 1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
SELECT `students`.`name`,
    `students`.`surname`,
    `students`.`date_of_birth`,
    `students`.`fiscal_code`,
    `degrees`.`name` as "Corso di Laurea"
FROM `students`
    INNER JOIN `degrees` ON `students`.`degree_id` = `degrees`.`id`
WHERE `degrees`.`name` LIKE "%economia%";

-- 2. Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze
SELECT `degrees`.`name` as "Corso di Laurea", `degrees`.`level`, `degrees`.`website`, `departments`.`name` as "Dipartimento"
FROM `degrees`
    INNER JOIN `departments` ON `degrees`.`department_id` = `departments`.`id`
WHERE `departments`.`name` LIKE "%neuroscienze%";

-- 3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)
SELECT `degrees`.*, `course_teacher`.`teacher_id` as "Fulvio Amato"
FROM `degrees`
    INNER JOIN `courses` ON `degrees`.`id` = `courses`.`degree_id`
    INNER JOIN `course_teacher` ON `courses`.`id` = `course_teacher`.`course_id`
WHERE `course_teacher`.`teacher_id` = 44;

-- 4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome
SELECT `students`.`name`,
    `students`.`surname`,
    `students`.`date_of_birth`,
    `students`.`fiscal_code`,
    `degrees`.`name` as "Corso di Laurea",
    `degrees`.`level`,
    `degrees`.`website`,
    `departments`.`name` as "Dipartimento"
FROM `students`
    INNER JOIN `degrees` ON `students`.`degree_id` = `degrees`.`id`
    INNER JOIN `departments` ON `degrees`.`department_id` = `departments`.`id`  
ORDER BY `students`.`surname` ASC, `students`.`name` ASC;

-- 5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti
SELECT `degrees`.`name` as "Corso di Laurea",
    `degrees`.`level`,
    `degrees`.`website`,
    `courses`.`name` as "Insegnamento del corso",
    `courses`.`description`,
    `courses`.`period`,
    `courses`.`year`,
    `courses`.`cfu`,
    `teachers`.`name` as "Nome insegnante",
    `teachers`.`surname`,
    `teachers`.`phone`,
    `teachers`.`email`
FROM `degrees`
    INNER JOIN `courses` ON `degrees`.`id` = `courses`.`degree_id`
    INNER JOIN `course_teacher` ON `courses`.`id` = `course_teacher`.`course_id`
    INNER JOIN `teachers` ON `course_teacher`.`teacher_id` = `teachers`.`id`
ORDER BY `degrees`.`name` ASC;

-- 6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)
SELECT `teachers`.`name` as "Nome insegnante",
`teachers`.`surname`,
`teachers`.`phone`,
`teachers`.`email`,
`departments`.`name` as "Dipartimento"
FROM `teachers`
    INNER JOIN `course_teacher` ON `teachers`.`id` = `course_teacher`.`teacher_id`
    INNER JOIN `courses` ON `course_teacher`.`course_id` = `courses`.`id`
    INNER JOIN `degrees` ON `courses`.`degree_id` = `degrees`.`id`
    INNER JOIN `departments` ON `degrees`.`department_id` = `departments`.`id`  
WHERE `departments`.`name` LIKE "%matematica%";

-- 7. BONUS: Selezionare per ogni studente il numero di tentativi sostenuti per ogni esame, stampando anche il voto massimo. Successivamente, filtrare i tentativi con voto minimo 18.
SELECT
    `students`.`name` as "Nome studente",
    `students`.`surname`,
    `students`.`date_of_birth`,
    `students`.`fiscal_code`,
    `courses`.`name` as "Insegnamento del corso",
    `courses`.`description`,
    `courses`.`period`,
    `courses`.`year`,
    `courses`.`cfu`,
    MAX(`exam_student`.`vote`) as "Voto massimo",
    COUNT(*) as "Numero di tentativi"
FROM `students`
INNER JOIN `exam_student` ON `students`.`id` = `exam_student`.`student_id`
INNER JOIN `exams` ON `exam_student`.`exam_id` = `exams`.`id`
INNER JOIN `courses` ON `exams`.`course_id` = `courses`.`id`
GROUP BY
    `students`.`id`,
    `students`.`name`,
    `students`.`surname`,
    `students`.`date_of_birth`,
    `students`.`fiscal_code`,
    `courses`.`id`,
    `courses`.`name`,
    `courses`.`description`,
    `courses`.`period`,
    `courses`.`year`,
    `courses`.`cfu`
HAVING MAX(`exam_student`.`vote`) >= 18;