import React from 'react';
import './App.css';
import SidebarExample from './components/SidebarExample';
import CardImplementation from './components/CardImplementation';
import NavbarExample from './components/NavbarExample';
import { Layout, Breadcrumb } from 'antd';
const { Header, Footer, Sider, Content, } = Layout;


class App extends React.Component {
  render() {
    return (
      <div>
        <Layout>
          <Header style={{ height: '97px', padding: '1px', float: 'left' }}>
            <NavbarExample></NavbarExample>

          </Header>
          <Layout>
            <Sider style={{ background: 'white', textAlign: 'center' }}>

              <SidebarExample></SidebarExample>

            </Sider>


            <Layout>

              <Content style={{ padding: '0 50px' }}>
                <Breadcrumb style={{ margin: '16px 0' }}>
                  <Breadcrumb.Item>Dashboard</Breadcrumb.Item>
                </Breadcrumb>

                <div style={{ background: '#fff', padding: 24, minHeight: 500 }}>
                  <CardImplementation></CardImplementation>
                </div>


              </Content>

              <Footer style={{ textAlign: 'center' }}>&copy; by GameStation</Footer>
            </Layout>
          </Layout>
        </Layout>
      </div>
    )
  }
}




export default App;
