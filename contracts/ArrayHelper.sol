pragma solidity >=0.5.0 <0.7.0;
/*
contract of various helper function in different operations.
*/

contract ArrayHelper{
    
    //function that returns index of any element in array of elements 
    //Return Type : uint
    
    //function for address data type
    //@dev inputs (array, value address for which you want to find index)
    function IndexOfAddressArray(address[] memory values, address value) public pure returns(uint,bool) {
        uint i = 0;
        while (values[i] != value) {
            i++;
        }
        if(i == values.length){
            return (0,false);
        }
        return (i,true);
    }
    
    //function for uint data type
    //@dev inputs (array, value of uint for which you want to find index)
    function IndexOfUintArray(uint[] memory values, uint value) public pure returns(uint,bool) {
        uint i = 0;
        while (values[i] != value) {
            i++;
        }
        if(i == values.length){
            return (0,false);
        }
        return (i,true);
    }
}