module move_gas_optimization::resource_update {
    use std::signer;

    struct MyResource has key, store {
        a:u128,
        b:u128,
        c:u128,
        d:u128,
        vec: vector<u64>,
        w:u8,
        x:u8,
        y:u8,
        z:u8
    }


    //aptos move run --function-id 'default::resource_update::create_resource'
    public entry fun create_resource(account: signer) {
        let vec = vector::empty<u64>();
        let k:u64 = 0;
        while (k < 100) {
            vector::push_back(&mut vec, k);
            k = k + 1;
        };
        move_to<MyResource>(&account, MyResource {
                a:1000,
                b:1000,
                c:1000,
                d:1000,
                vec: vec,
                w:10,
                x:10,
                y:10,
                z:10
            });
    }
    

    //aptos move run --function-id 'default::resource_update::bad_resource_update' --args 'u8:1'
    public entry fun bad_resource_update(account: &signer, new_value: u8) 
    acquires MyResource{
        // transfer from global storage
        let resource = move_from<MyResource>(signer::address_of(account));

        // destroy
        let MyResource {
            a:a,
            b:b,
            c:c,
            d:d,
            vec: vec,
            w:w,
            x:_,
            y:y,
            z:z
        } = resource;

        // create new resource
        move_to<MyResource>(account, MyResource {
            a:a,
            b:b,
            c:c,
            d:d,
            vec: vec,
            w:w,
            x:new_value,
            y:y,
            z:z
        });
    }
    // 130 Octa


    //aptos move run --function-id 'default::resource_update::good_resource_update' --args 'u8:1'
    public entry fun good_resource_update(account: &signer, new_value: u8) 
    acquires MyResource{
        let resource = borrow_global_mut<MyResource>(signer::address_of(account));
        resource.x = new_value;
    }
    // 120 Octa

}
