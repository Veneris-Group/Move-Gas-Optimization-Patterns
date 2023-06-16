module move_gas_optimization::limit_function_calls {
   

   public fun helper_function() {

    }


    //aptos move run --function-id 'default::limit_function_calls::function_call'
    public entry fun function_call() {
        let k:u64 = 0;
        while (k < 1000) {
            helper_function();
            k = k + 1;
        };
    }
    // 47 Octa

    
    //aptos move run --function-id 'default::limit_function_calls::no_function_call'
    public entry fun no_function_call() {
        let k:u64 = 0;
        while (k < 1000) {
            // no function call
            k = k + 1;
        };
    }
    // 21 Octa


}
