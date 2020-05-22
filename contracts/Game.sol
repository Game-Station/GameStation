pragma solidity >=0.5.0 <0.7.0;
import "./GameDev.sol";
import "./ArrayHelper.sol";

/*
Access Modifiers :
    Insert:     The only registered developer is able to register the game.
    
    Update:     The only registered developer is able to update details of any game which is registered
                by him/her only.
    
    View:       anyone can view the details of registered games.
    
Game Managers:
    Add Game Manager    : only owner of game can add game manager for any game.
    Remove Game Manager : only owner of game can remove game manager for any game.

Required Inputs from user
    1. Game Name
    2. Game Owner ID(Address)
    4. IPFS hash of Game ICON
    5. Game Description
    6. Age Restriction
    7. API KEY

while add/remove manager for any game
    1. Game ID
    2. Manager's account address
*/


contract Games is GameDev,ArrayHelper{
    
    struct Game{
        string gameName;
        string gameIconIpfsHash;
        uint gameAgeLimit;
        string gameDescription;
        string gameApiKey;
        address[] gameManagerArray;
    }
    
    Game[] public game;
    
    //@dev mapping to check manager exists for perticular game or not.
    mapping (uint => mapping (address => bool)) managerExists;
    //@dev mapping for game to game owner.
    mapping(uint=>address) gameToOwner;
    //@mapping to check existance of game
    mapping(uint=>bool) gameExists;
    
    
    /* @dev
            -function to registered any new game.
            -only registred devs can register new game.
            -Input Sequence
                1. Game Name
                2. Game Icon IPFS hash
                3. minimum Age Requirement
                4. Game Description
                5. Api Key 
    */
    function addGame(string memory _gameName,string memory _gameIconIpfsHash,uint _gameAge,string memory _gameDesc, string memory _apiKey) public{
        require(gameDevIsRegistered[msg.sender]);
        uint id = game.push(Game(_gameName,_gameIconIpfsHash,_gameAge,_gameDesc,_apiKey,new address[](0))) - 1;
        managerExists[id][msg.sender] = true;
        gameToOwner[id] = msg.sender;
        ownerGameCount[msg.sender] = ownerGameCount[msg.sender].add(1);
        game[id].gameManagerArray.push(msg.sender);
        gameExists[id] = true;
    }
    
    /* @dev
        -function to update parameters of game.
        -update the required parameter, leave all other as it is.
        -only game owner and game mana can update the parameters.
        -Input Sequense same as addGame, only API KEY is not included.
    */
    function updateGame(uint _gameId,string memory _gameName,string memory _gameIconIpfsHash,string memory _gameDesc,uint _gameAge) public onlyGameManager(_gameId) {
        require(gameExists[_gameId]);
        game[_gameId].gameName = _gameName;
        game[_gameId].gameIconIpfsHash = _gameIconIpfsHash;
        game[_gameId].gameAgeLimit = _gameAge;
        game[_gameId].gameDescription = _gameDesc;
    }
    
    /* @dev
        -function to view all the games own by one org.
        -return type : array of uint.
        -Input Parameter : org's account address.
    */
    function viewGames(address _gameOwnerAddress) external view returns(uint[] memory){
        uint[] memory gameIDs = new uint[](ownerGameCount[msg.sender]);
        uint counter = 0;
        for(uint i=0;i<game.length;i++){
            if(gameToOwner[i]==_gameOwnerAddress){
                gameIDs[counter] = i;
                counter++;
            }
        }
        return gameIDs;
    }
    
    /* @dev
        -function to add game manager.
        -Input Parameters (gameID,manager's account address)
    */
    function addGameManager(uint _gameId,address _gameManagerAddress) external onlyGameOwner(_gameId){
        require(gameExists[_gameId]);
        game[_gameId].gameManagerArray.push(_gameManagerAddress);
    }
    
    /* @dev
        -function to remove game manager from any game.
        -Input Parameters (gameID,game manager's account address)
    */
    function removeGameManager(uint _gameId,address _gameManagerAddress) public onlyGameOwner(_gameId){
        uint i;
        bool result;
        (i,result) = IndexOfAddressArray(game[_gameId].gameManagerArray,_gameManagerAddress);
        if(result){
            delete game[_gameId].gameManagerArray[i];
            game[_gameId].gameManagerArray[i] = game[_gameId].gameManagerArray[game[_gameId].gameManagerArray.length - 1];
            game[_gameId].gameManagerArray.length--;
        }
    }
    
    // @dev modifire to check weather user is game owner or not.
    modifier onlyGameOwner(uint _gameId){
        require(gameToOwner[_gameId]==msg.sender);
        _;
    }

    // @dev modifire to check weather user is game manager or not.
    modifier onlyGameManager(uint _gameId){
        require(managerExists[_gameId][msg.sender] || gameToOwner[_gameId] == msg.sender);
        _;
    }

}