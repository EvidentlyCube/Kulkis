package {
    public function ASSERT(condition:*, message:String = null):void{
        if (!condition)
        {
            throw new Error(message ? message : "Assertion failed!");
        }
    }
}
