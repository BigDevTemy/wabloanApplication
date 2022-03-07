<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;
class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        app()[\Spatie\Permission\PermissionRegistrar::class]->forgetCachedPermissions();
        //Permission::create(['name' => 'create.review_team_member']);
        //Permission::create(['name' => 'create.review_teamlead']);
        //Permission::create(['name' => 'create.collection_teamlead']);
        //Permission::create(['name' => 'view.tickets']);
        //Permission::create(['name' => 'review.tickets']);
        //Permission::create(['name' => 'close.tickets']);
        //Permission::create(['name' => 'view.all_loans']);
        //Permission::create(['name' => 'view.all_unpaid_loans']);
        //Permission::create(['name' => 'view.all_pending_loans_review']);
        //Permission::create(['name' => 'view.all_assigned_pending_loans_review']);
        //Permission::create(['name' => 'assign_to_review_member']);
        //Permission::create(['name' => 'report.review_loans']);
        //Permission::create(['name' => 'report.collection_loans']);
        //Permission::create(['name' => 'assign_to_collection_member']);
        Permission::create(['name' => 'collection.repayment']);
        Permission::create(['name' => 'collection.view_overdue_loans']);
        Permission::create(['name' => 'collection.forcedebit_account']);
        //Permission::create(['name' => 'approve_loan']);
        //Permission::create(['name' => 'disapprove_loan']);
        //Permission::create(['name' => 'view_service_jobs']);
        //Permission::create(['name' => 'close_jobs']);
       
        // create roles and assign created permissions

        // this can be done as separate statements
        //$role = Role::create(['name' => 'super_admin']);
        //$role->givePermissionTo(Permission::all());

        // or may be done by chaining
        //$role = Role::create(['name' => 'review_teamlead']);
        //$role->givePermissionTo(['view.all_pending_loans_review','assign_to_review_member','report.review_loans']);

        //$role = Role::create(['name' => 'review_team_member']);
        //$role->givePermissionTo(['view.all_assigned_pending_loans_review','approve_loan','disapprove_loan']);

        //$role = Role::create(['name' => 'collection_teamlead']);
        //$role->givePermissionTo(['report.collection_loans','repayment','assign_to_collection_member']);

        //$role = Role::create(['name' => 'collection_team_member']);
        //$role->givePermissionTo(['report.collection_loans','repayment']);

        //$role = Role::create(['name' => 'customer_care']);
        //$role->givePermissionTo(['view.tickets','review.tickets','close.tickets']);

        $role = Role::create(['name' => 'collection_team_member_S0']);
        $role->givePermissionTo(['collection.repayment','collection.view_overdue_loans','collection.forcedebit_account']);
             $role = Role::create(['name' => 'collection_team_member_S1']);
        $role->givePermissionTo(['collection.repayment','collection.view_overdue_loans','collection.forcedebit_account']);
             $role = Role::create(['name' => 'collection_team_member_S2']);
        $role->givePermissionTo(['collection.repayment','collection.view_overdue_loans','collection.forcedebit_account']);
             $role = Role::create(['name' => 'collection_team_member_M1']);
        $role->givePermissionTo(['collection.repayment','collection.view_overdue_loans','collection.forcedebit_account']);
             $role = Role::create(['name' => 'collection_team_member_m2']);
        $role->givePermissionTo(['collection.repayment','collection.view_overdue_loans','collection.forcedebit_account']);
    }
}
