-- CreateEnum
CREATE TYPE "Perfil" AS ENUM ('ALUNO', 'PERSONAL', 'ADMIN');

-- CreateEnum
CREATE TYPE "StatusAgendamento" AS ENUM ('PENDENTE', 'CONFIRMADO', 'CANCELADO');

-- CreateTable
CREATE TABLE "Tenant" (
    "_id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Tenant_pkey" PRIMARY KEY ("_id")
);

-- CreateTable
CREATE TABLE "User" (
    "_id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "tenantId" TEXT NOT NULL,
    "perfil" "Perfil" NOT NULL,
    "isAdmin" BOOLEAN NOT NULL DEFAULT false,
    "ativo" BOOLEAN NOT NULL DEFAULT true,
    "refresh_token" TEXT,
    "resetToken" TEXT,
    "tokenExpiration" TIMESTAMP(3),
    "whatsapp" TEXT,
    "dataNascimento" TIMESTAMP(3),
    "genero" TEXT,
    "acessoEmail" BOOLEAN,
    "bloqueado" BOOLEAN,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("_id")
);

-- CreateTable
CREATE TABLE "AvaliacaoFisica" (
    "_id" TEXT NOT NULL,
    "alunoId" TEXT NOT NULL,
    "tenantId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "AvaliacaoFisica_pkey" PRIMARY KEY ("_id")
);

-- CreateTable
CREATE TABLE "Exercicio" (
    "_id" TEXT NOT NULL,
    "nome" TEXT NOT NULL,
    "descricao" TEXT,
    "grupoMuscular" TEXT NOT NULL,
    "videoUrl" TEXT,
    "createdById" TEXT NOT NULL,
    "tenantId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Exercicio_pkey" PRIMARY KEY ("_id")
);

-- CreateTable
CREATE TABLE "Treino" (
    "_id" TEXT NOT NULL,
    "nome" TEXT NOT NULL,
    "objetivo" TEXT,
    "tenantId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Treino_pkey" PRIMARY KEY ("_id")
);

-- CreateTable
CREATE TABLE "TreinoExercicio" (
    "_id" TEXT NOT NULL,
    "treinoId" TEXT NOT NULL,
    "exercicioId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "TreinoExercicio_pkey" PRIMARY KEY ("_id")
);

-- CreateTable
CREATE TABLE "HistoricoTreino" (
    "_id" TEXT NOT NULL,
    "treinoId" TEXT NOT NULL,
    "tenantId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "HistoricoTreino_pkey" PRIMARY KEY ("_id")
);

-- CreateTable
CREATE TABLE "Agendamento" (
    "_id" TEXT NOT NULL,
    "agendaId" TEXT NOT NULL,
    "status" "StatusAgendamento" NOT NULL DEFAULT 'PENDENTE',
    "dataAgendada" TIMESTAMP(3) NOT NULL,
    "confirmadoEm" TIMESTAMP(3),
    "criadoEm" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "atualizadoEm" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Agendamento_pkey" PRIMARY KEY ("_id")
);

-- CreateTable
CREATE TABLE "Agenda" (
    "_id" TEXT NOT NULL,
    "nome" TEXT NOT NULL,
    "tenantId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Agenda_pkey" PRIMARY KEY ("_id")
);

-- CreateTable
CREATE TABLE "PlanoUsuario" (
    "_id" TEXT NOT NULL,
    "nome" TEXT NOT NULL,
    "tenantId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PlanoUsuario_pkey" PRIMARY KEY ("_id")
);

-- CreateTable
CREATE TABLE "Rotina" (
    "_id" TEXT NOT NULL,
    "nome" TEXT NOT NULL,
    "descricao" TEXT,
    "tenantId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Rotina_pkey" PRIMARY KEY ("_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "Tenant"("_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AvaliacaoFisica" ADD CONSTRAINT "AvaliacaoFisica_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "Tenant"("_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Exercicio" ADD CONSTRAINT "Exercicio_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "User"("_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Exercicio" ADD CONSTRAINT "Exercicio_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "Tenant"("_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Treino" ADD CONSTRAINT "Treino_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "Tenant"("_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TreinoExercicio" ADD CONSTRAINT "TreinoExercicio_treinoId_fkey" FOREIGN KEY ("treinoId") REFERENCES "Treino"("_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TreinoExercicio" ADD CONSTRAINT "TreinoExercicio_exercicioId_fkey" FOREIGN KEY ("exercicioId") REFERENCES "Exercicio"("_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "HistoricoTreino" ADD CONSTRAINT "HistoricoTreino_treinoId_fkey" FOREIGN KEY ("treinoId") REFERENCES "Treino"("_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "HistoricoTreino" ADD CONSTRAINT "HistoricoTreino_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "Tenant"("_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Agendamento" ADD CONSTRAINT "Agendamento_agendaId_fkey" FOREIGN KEY ("agendaId") REFERENCES "Agenda"("_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Agenda" ADD CONSTRAINT "Agenda_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "Tenant"("_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PlanoUsuario" ADD CONSTRAINT "PlanoUsuario_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "Tenant"("_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Rotina" ADD CONSTRAINT "Rotina_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "Tenant"("_id") ON DELETE RESTRICT ON UPDATE CASCADE;
