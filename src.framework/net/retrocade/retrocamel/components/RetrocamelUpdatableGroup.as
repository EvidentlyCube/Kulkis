

package net.retrocade.retrocamel.components{
    import net.retrocade.retrocamel.interfaces.IRetrocamelUpdatable;

    final public class RetrocamelUpdatableGroup implements IRetrocamelUpdatable{
        /**
         * An array of group's objects
         */
        protected var _objects:Array;

        /**
         * Returns the amount of not nulled elements in the group
         */
        public function get length():uint{
            return _objectsArrayLength - _nulledObjectsCount;
        }

        /**
         * Length of the items arrays
         */
        protected var _objectsArrayLength:Number = 0;



        /**
         * HELPER: Counts how many elements were nulled
         */
        protected var _nulledObjectsCount:uint = 0;

        /**
         * Amount of Null variables in list which should turn the GC on automatically
         */
        public var gcThreshold:uint = 10;

        /**
         * If true automatic GC will use advanced garbage collection
         */
        public var useAdvancedGc :Boolean = false;

        /**
         * HELPER: True if the group is currently updating
         */ 
        protected var isUpdating:Boolean = false;

        /**
         * HELPER: Index of the currently updated element
         */ 
        protected var updatingIndex:int = -1;

        /**
         * Constructor
         */
        public function RetrocamelUpdatableGroup(){
            _objects = [];
        }




        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Adding
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Adds an object at the end of the group
         * @param object rIUpdatable to be added to the group
         */
        public function add(object:IRetrocamelUpdatable):void{
            _objects[_objectsArrayLength++] = object;
        }

        /**
         * Adds an object to the group at specified index
         * @param object rIUpdatable to be added to the group
         * @param index Index where to add the item to the group
         */
        public function addAt(object:IRetrocamelUpdatable, index:uint):void{
            if (index > _objectsArrayLength){
                _objects.length = index - 1;
            }

            _objects.splice(index, 0, object);
            _objectsArrayLength = _objects.length;
        }


        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Garbage Collecting
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Removes all Nulled objects from group and fills gap with items from the end of the list.
         * Order is not retained
         */
        public function garbageCollect():void{
            var l:uint = _objectsArrayLength;
            var i:uint = 0;

            for (;i < l; ++i){
                while (_objects[i] == null && i < l){
                    _objects[i] = _objects[--l];
                }
            }

            _objects.length = l;
            _nulledObjectsCount       = 0;
            _objectsArrayLength       = l;
        }

        /**
         * Splices all Nulled objects from group, Order is retained.
         */
        public function garbageCollectAdvanced():void{
            var l  :uint = _objectsArrayLength;
            var i  :uint = 0;
            var gap:uint = 0;

            for (;i < l; i++){
                if (_objects[i] == null){
                    gap++;

                } else if (gap){
                    _objects[i - gap] = _objects[i];
                }
            }

            _objectsArrayLength       -= gap;
            _objects.length -= gap;
            _nulledObjectsCount        = 0;
        }




        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Removing
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Removes all elements from the group
         */
        public function clear():void{
           _objects.length = 0;
           _objectsArrayLength = 0;
           _nulledObjectsCount = 0;
        }

        /**
         * Nulls the specified object from the group
         * @param object Object to be nulled
         */
        public function nullify(object:IRetrocamelUpdatable):void{
            var index:int = _objects.indexOf(object);
            if (index == -1)
                return;

            _nulledObjectsCount++;
            _objects[index] = null;
        }

        /**
         * Removes the specified object from the group using splice
         * @param object Object to be removed
         */
        public function remove(object:IRetrocamelUpdatable):void{
            var index:int = _objects.indexOf(object);
            if (index == -1)
                return;

            _objectsArrayLength--;
            _objects.splice(index, 1);
            
            if (isUpdating && index < updatingIndex)
                updatingIndex--;
        }


        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Updating
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Calls update on all active elements
         */
        public function update():void{
            if (isUpdating)
                throw new Error("You can't update group when it is already in the process of updating");
            
            isUpdating = true;
            updatingIndex = 0;
            
            //try{
                for(var o:IRetrocamelUpdatable; updatingIndex < _objectsArrayLength; updatingIndex++){
                    o = _objects[updatingIndex];
                    
                    if (o)
                        o.update();
                }
            //} catch(e:*){
            //    isUpdating = false;
            //    updatingIndex = -1;
            //    
            //    throw e;
            //}
            
            isUpdating = false;
            updatingIndex = -1;

            // Garbage Collect
            if (_nulledObjectsCount > gcThreshold) {
                if (useAdvancedGc) garbageCollectAdvanced(); else garbageCollect();
            }
        }
    }
}