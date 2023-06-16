module move_gas_optimization::short_circuit {

    public fun expensive_function(): bool {
        let k:u64 = 0;
        while (k < 100000) {
            k = k + 1;
        };
        let b: bool = (k == 0);
        b
    }
    // always returns False

    public fun cheap_function(): bool {
        let k:u64 = 0;
        while (k < 10) {
            k = k + 1;
        };
        let b: bool = (k == 0);
        b
    }
    // always returns False


    //aptos move run --function-id 'default::short_circuit::no_short_circuit'
    public entry fun no_short_circuit() {
        if (expensive_function() && cheap_function()) {

        };
    }
    // 2372 Octa


    //aptos move run --function-id 'default::short_circuit::short_circuit'
    public entry fun short_circuit() {
        if (cheap_function() && expensive_function()) {

        };
    }
    // 200 Octa

}
