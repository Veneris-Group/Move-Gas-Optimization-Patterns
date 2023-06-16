module move_gas_optimization::operate_on_local_variables {
    use std::signer;
    
    struct MyResource has key, store {
        value: u64
    }

    //aptos move run --function-id 'default::operate_on_local_variables::create_resource'
    public entry fun create_resource(account: signer) {
        move_to<MyResource>(&account, MyResource {
                value: 1
            });
    }

    //aptos move run --function-id 'default::operate_on_local_variables::bad_resource_write'
    public entry fun bad_resource_write(account: &signer) 
    acquires MyResource{
        let resource = borrow_global_mut<MyResource>(signer::address_of(account));
        resource.value = 0;
        while (resource.value < 100000) {
            //
            // operate on resource.field
            //
            resource.value = resource.value + 1;
        };
    }
    // 62 Octa


    //aptos move run --function-id 'default::operate_on_local_variables::good_resource_write'
    public entry fun good_resource_write(account: &signer) 
    acquires MyResource{
        let resource = borrow_global_mut<MyResource>(signer::address_of(account));
        resource.value = 0;
        let intermediate = resource.value;

        while (intermediate < 100000) {
            //
            // operate on intermediate
            //
            intermediate = intermediate + 1;
        };
        resource.value = intermediate;
    }
    // 27 Octa

}
