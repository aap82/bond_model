import React from 'react';
import ReactDOM from 'react-dom';
import createBrowserHistory from 'history/createBrowserHistory';
import {Provider} from 'mobx-react';
import { RouterStore, syncHistoryWithStore } from 'mobx-react-router';
import { Router } from 'react-router-dom';
import { AppContainer } from 'react-hot-loader';
import {configureStores} from '../store';
import gqlFetch from '../../utils/fetch';

const browserHistory = createBrowserHistory();
const stores = configureStores(gqlFetch('./graphql'))
const history = syncHistoryWithStore(browserHistory, stores.routing);

import App from '../App';

const render = (Component) => {
  ReactDOM.render(
    <AppContainer>
      <Provider {...stores}>
          <Router history={history}>
            <Component />
          </Router>
      </Provider>
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