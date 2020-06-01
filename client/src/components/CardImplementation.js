import React from 'react';
import Card from 'react-bootstrap/Card';
import Button from 'react-bootstrap/Button';
import { Timeline } from 'antd';
import { ClockCircleOutlined } from '@ant-design/icons';


class CardImplementation extends React.Component{
    render(){
        return(
            <div>
                <Card style={{width:'50rem'}} className="text-center" border="success">
                    <Card.Header style={{textAlign:'left'}}>Your Games
                        <Button style={{ float: 'right' }} variant="success">+  Register</Button>
                    </Card.Header>
                    <Card.Body style={{ textAlign: 'left' }}>
                        <Card.Title>Game Name:-
                            
                            <Timeline style={{ margin: '10px', float: 'right' }}>
                                <Timeline.Item>Create a services site 2015-09-01</Timeline.Item>
                                <Timeline.Item>Solve initial network problems 2015-09-01</Timeline.Item>
                                <Timeline.Item dot={<ClockCircleOutlined className="timeline-clock-icon" />} color="red">
                                    Technical testing 2015-09-01
    </Timeline.Item>
                                <Timeline.Item>Network problems being solved 2015-09-01</Timeline.Item>
                            </Timeline>
                        </Card.Title>
                        <footer style={{ margin: '10px' }} className="blockquote-footer">
                           GameID:- 
                        </footer>
                        <footer style={{margin:'10px'}} className="blockquote-footer">
                            Created no.of days ago
                                <Button style={{ margin: '8px' }} variant="outline-primary">view Game</Button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <Button variant="outline-primary">Game State</Button>
                        </footer>
                        
                    </Card.Body>
                    <Card.Footer className="text-muted"></Card.Footer>
                </Card>
            </div>
        )
    }
}

export default CardImplementation;