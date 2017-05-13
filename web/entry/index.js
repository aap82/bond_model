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
const fetch = gqlFetch('./graphql')

const routingStore = new RouterStore()
const stores = configureStores(fetch, routingStore)
const history = syncHistoryWithStore(browserHistory, routingStore);
import { configureDevtool } from 'mobx-react-devtools'
import App from '../App';

configureDevtool({
    logEnabled: false,
    updatesEnabled: false,
    // logFilter: change => change.type !== 'reaction'
})
const render = (Component) => {
  ReactDOM.render(
    <AppContainer>
      <Provider {...stores}>
        <Router history={history} >
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
      const NextApp = require('../App').default
      render(NextApp)
  });
}