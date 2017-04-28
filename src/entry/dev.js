import React from 'react';
import ReactDOM from 'react-dom';

import { AppContainer } from 'react-hot-loader';
import App from '../App';
import collateralStore from '../store/collateral/Collateral';



const render = (Component) => {
  ReactDOM.render(
  <AppContainer>
    <Component store={collateralStore}/>
  </AppContainer>,
    document.getElementById('root')
  );
};

render(App);

// Hot Module Replacement API
if (module.hot) {
  module.hot.accept('../App', () => {
    render(App)
  });
}