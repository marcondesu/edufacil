/*
  Warnings:

  - You are about to drop the column `name` on the `aluno` table. All the data in the column will be lost.
  - You are about to drop the column `name` on the `disciplina` table. All the data in the column will be lost.
  - You are about to drop the column `name` on the `professor` table. All the data in the column will be lost.
  - Added the required column `nome` to the `aluno` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nome` to the `disciplina` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nome` to the `professor` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_aluno" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "nome" TEXT NOT NULL,
    "email" TEXT NOT NULL
);
INSERT INTO "new_aluno" ("email", "id") SELECT "email", "id" FROM "aluno";
DROP TABLE "aluno";
ALTER TABLE "new_aluno" RENAME TO "aluno";
CREATE UNIQUE INDEX "aluno_email_key" ON "aluno"("email");
CREATE TABLE "new_disciplina" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "nome" TEXT NOT NULL,
    "professorId" TEXT NOT NULL,
    CONSTRAINT "disciplina_professorId_fkey" FOREIGN KEY ("professorId") REFERENCES "professor" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_disciplina" ("id", "professorId") SELECT "id", "professorId" FROM "disciplina";
DROP TABLE "disciplina";
ALTER TABLE "new_disciplina" RENAME TO "disciplina";
CREATE TABLE "new_professor" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "nome" TEXT NOT NULL,
    "email" TEXT NOT NULL
);
INSERT INTO "new_professor" ("email", "id") SELECT "email", "id" FROM "professor";
DROP TABLE "professor";
ALTER TABLE "new_professor" RENAME TO "professor";
CREATE UNIQUE INDEX "professor_email_key" ON "professor"("email");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
