/*
  Warnings:

  - The values [INVESTMENT] on the enum `bank_account_type` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the column `userId` on the `bank_accounts` table. All the data in the column will be lost.
  - Added the required column `user_id` to the `bank_accounts` table without a default value. This is not possible if the table is not empty.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "bank_account_type_new" AS ENUM ('CHECKING', 'INVESTMENT8', 'CASH');
ALTER TABLE "bank_accounts" ALTER COLUMN "type" TYPE "bank_account_type_new" USING ("type"::text::"bank_account_type_new");
ALTER TYPE "bank_account_type" RENAME TO "bank_account_type_old";
ALTER TYPE "bank_account_type_new" RENAME TO "bank_account_type";
DROP TYPE "bank_account_type_old";
COMMIT;

-- AlterTable
ALTER TABLE "bank_accounts" DROP COLUMN "userId",
ADD COLUMN     "user_id" UUID NOT NULL;

-- AddForeignKey
ALTER TABLE "bank_accounts" ADD CONSTRAINT "bank_accounts_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
