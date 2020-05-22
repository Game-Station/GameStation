pragma solidity >=0.5.0 <0.7.0;

import "./Game.sol";
/*
Access:
    Add Achievement:    The only registered game developer is able to add an achievement
                        for any game that is registered by him/her.
    
    Update Achievement: The only registered game developer is able to update an achievement
                        for any game that is registered by him/her.
    
    View:               anyone can view the list of different achievements of any particular
                        game.
    
    Delete Achievement: only game owner can delete acheivement.

Mappings:
  Need to map achievement with the registered game, and registered game developer who is the
  owner/developer of that game.

Required inputs from the user
    1. Achievement Name
    2. Achievement Description
    3.IPFS hash of achievement icon
*/

contract GameAchievements is Games{
    
    struct Achievements {
        string achievement_name;
        string achievement_desc;
        string achievement_Icon_hash;
    }
    
    Achievements[] achievements;
    
    // @dev mapping of achiveent to game
    mapping (uint=>uint) achievementToGame;
    // @dev count of number of acheivements of any perticular game
    mapping (uint=>uint) public gameAchievementCount;
    // @dev mapping to check weather achievement exists or not
    mapping (uint=>bool) achievementExists;
    
    /* @dev
        -function to add new acheivements to any registered gameExists
        -only owner of game can add new acheivements.
        -Input Sequence
            1. Game Id
            2. Acheivement Name
            3. Acheivement Description
            4. Acheivement Icon's IPFS Hash
    */
    function addAchievement( uint _gameId, string memory _achievementName, string memory _achievementDesc, string memory _achievementIconHash) public onlyGameOwner(_gameId){
        require(gameExists[_gameId]);
        uint id = achievements.push(Achievements(_achievementName, _achievementDesc, _achievementIconHash)) - 1;
        achievementToGame[id] = _gameId;
        achievementExists[id] = true;
        gameAchievementCount[_gameId] = gameAchievementCount[_gameId].add(1);
    }
    
    /* @dev
        -function to update parameters of any acheivement.
        -Input Sequence
            1. Game Id
            2. Acheivement Id
            3. Acheivement Name
            4. Acheivement Description
            5. Acheivement Icon IPFS Hash
        -change the require parameters, leave all other as it is.
    */
    function updateAchievement(uint _gameId, uint _achievementId,string memory _achievementName, string memory _achievementDesc, string memory _achievementIconHash) public onlyGameManager(_gameId){
        require(achievementExists[_achievementId]);
        achievements[_achievementId].achievement_name = _achievementName;
        achievements[_achievementId].achievement_desc = _achievementDesc;
        achievements[_achievementId].achievement_Icon_hash = _achievementIconHash;
        gameAchievementCount[_gameId] = gameAchievementCount[_gameId].add(1);
    }
    
    
    /* @dev
        -function to view all the acheivements of any game.
        -return type array of uint.
        -Input Parameter : Game Id.
    */
    function viewAchievements(uint _gameId) public view returns(uint[] memory){
        uint[] memory Aid = new uint[](gameAchievementCount[_gameId]);
        uint count = 0;
        for(uint i=0; i<achievements.length; i++){
            if(achievementToGame[i] == _gameId){
                Aid[count] = i;
                count++;
            }
        }
        return Aid;
    }
    
    /* @dev
        -function to view details of any acheivement.
        -Input parameter : Acheivement Id
        -return type (str, str, str)
        -return value (Acheivement Name, Acheivement Description, Acheivement Icon's IPFS Hash)
    */
    function viewAchievement(uint _achievementId) public view returns(string memory,string memory,string memory){
        return (achievements[_achievementId].achievement_name,achievements[_achievementId].achievement_desc,achievements[_achievementId].achievement_Icon_hash);
    }
    
    /* @dev
        -function to view all the details of any game.
        -Input parameter : game ID
        -Output Datatype Sequence : (str, str, uint, str, str, address[], uint[])
        -Output Sequence : (Game Name, Game Icon IPFS Hash, Minimum Age requirement of game, ame Description, Game API Key, Game Managers, Game Achievements)
    */
    function viewGame(uint _gameId) external view onlyGameManager(_gameId) returns(string memory,string memory,uint,string memory,string memory,address[] memory, uint[] memory){
        uint[] memory acheivementsOfGame = viewAchievements(_gameId);        
        return(game[_gameId].gameName,game[_gameId].gameIconIpfsHash,game[_gameId].gameAgeLimit,game[_gameId].gameDescription,game[_gameId].gameApiKey,game[_gameId].gameManagerArray, acheivementsOfGame);
    }
    
    
}