pragma solidity >=0.4.0 <0.7.0;
import "./SafeMath.sol";

/*
Required Inputs from user
    1. Name of organization
    2. Name of Owner
    3. IPFS HASH of org logo (Default logo in case if no logo available )
    4. Address
    5. Email ID/contact details
    6. website
*/

//HERE USER MEANS GAME DEVELOPER OR GAME OWNER

contract GameDev{
    
    using SafeMath for uint256;
    using SafeMath for uint32;
    using SafeMath for uint16;
    using SafeMath for uint8;
    
    struct gameDev{
        address gameDev_owners_acc_address;
        string gameDev_owner_name;
        string gameDev_company_logo_IPHASH;
        string gameDev_orgs_address;
        string gameDev_org_email_id;
    }
    
    //@dev mapping of user address with users info.
    mapping(address=>gameDev) gameDevStruct;
    //@dev count to track number of games own by user
    mapping(address=>uint) public ownerGameCount;
    //@dev to check game developer is regisrered or not
    mapping(address=>bool) gameDevIsRegistered;
    
    /*@dev 
        -function to register new game dev. org.
        -user can registered only ones using one acc. address.
        -Input Sequense
            1. owner's Name
            2. company logo's IPFS hash
            3. org's physical address
            4. org's email ID
    */
    function addGameDevOrg(string memory _ownerName,string memory _companyLogoIPHASH,string memory _orgAddress,string memory _orgEmailId) public{
        require(!gameDevIsRegistered[msg.sender]);
        address msg_sender = msg.sender;
        gameDevStruct[msg_sender] = gameDev(msg_sender,_ownerName,_companyLogoIPHASH,_orgAddress,_orgEmailId);    
        gameDevIsRegistered[msg.sender] = true;
    }

    /* @dev
        -function to update org's info.
        -only registered org's can update their info.
        -input sequence same as addGameDevOrg function.
        -only change value you want to update, leave all other details as it is.
    */
    function updateGameDevOrgInfo(string memory owner_name,string memory company_logo_IPHASH,string memory orgs_address,string memory org_email_id) public{
        require(gameDevIsRegistered[msg.sender]);
        address msg_sender = msg.sender;
        gameDevStruct[msg_sender] = gameDev(msg_sender,owner_name,company_logo_IPHASH,orgs_address,org_email_id);
    }
    
    /* @dev
        -function to view details of any registered org.
        -returns all 0x00 values of org. address is not registered.
        -Output sequence
            1. Owner's Name
            2. org. logo's IPFS hash
            3. org's physical address
            4. org's email ID
    */
    function viewGameDevOrgInfo(address _address) public view returns(string memory,string memory,string memory,string memory){
        gameDev storage g1 = gameDevStruct[_address];
        return(g1.gameDev_owner_name,g1.gameDev_company_logo_IPHASH,g1.gameDev_orgs_address,g1.gameDev_org_email_id);
    }
    
}