<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;

class RoleAndPermision extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        app()[\Spatie\Permission\PermissionRegistrar::class]->forgetCachedPermissions();
        Permission::create(['name' => 'create.review_team_member']);
        Permission::create(['name' => 'create.review_teamlead']);
        Permission::create(['name' => 'create.collection_teamlead']);
        Permission::create(['name' => 'view.tickets']);
        Permission::create(['name' => 'review.tickets']);
        Permission::create(['name' => 'close.tickets']);
        Permission::create(['name' => 'view.all_loans']);
        Permission::create(['name' => 'view.all_unpaid_loans']);
        Permission::create(['name' => 'view.all_pending_loans_review']);
        Permission::create(['name' => 'view.all_assigned_pending_loans_review']);
        Permission::create(['name' => 'assign_to_review_member']);
        Permission::create(['name' => 'report.review_loans']);
        Permission::create(['name' => 'report.collection_loans']);
        Permission::create(['name' => 'assign_to_collection_member']);
        Permission::create(['name' => 'repayment']);
        Permission::create(['name' => 'approve_loan']);
        Permission::create(['name' => 'disapprove_loan']);
        Permission::create(['name' => 'view_service_jobs']);
        Permission::create(['name' => 'close_jobs']);
        

        
        

        // create roles and assign created permissions

        // this can be done as separate statements
        $role = Role::create(['name' => 'super_admin']);
        $role->givePermissionTo(Permission::all());

        // or may be done by chaining
        $role = Role::create(['name' => 'review_teamlead']);
        $role->givePermissionTo(['view.all_pending_loans_review','assign_to_review_member','report.review_loans']);

        $role = Role::create(['name' => 'review_team_member']);
        $role->givePermissionTo(['view.all_assigned_pending_loans_review','approve_loan','disapprove_loan']);

        $role = Role::create(['name' => 'collection_teamlead']);
        $role->givePermissionTo(['report.collection_loans','repayment','assign_to_collection_member']);

        $role = Role::create(['name' => 'collection_team_member']);
        $role->givePermissionTo(['report.collection_loans','repayment']);

        $role = Role::create(['name' => 'customer_care']);
        $role->givePermissionTo(['view.tickets','review.tickets','close.tickets']);

        $role = Role::create(['name' => 'technican']);
        $role->givePermissionTo(['view_service_jobs','close_jobs']);


    }
}
