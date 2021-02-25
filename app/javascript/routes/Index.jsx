import React from "react";
import { BrowserRouter as Router, Route, Switch } from "react-router-dom";
import Home from "../components/Home";
import AllEmployers from "../components/AllEmployers";
import Employer from "../components/Employer";
import AllEarnings from "../components/AllEarnings";
import Earning from "../components/Earning";

export default (
  <Router>
    <Switch>
      <Route path="/" exact component={Home} />
      <Route path="/employers" exact component={AllEmployers} />
      <Route path="/employers/:id" exact component={Employer} />
      <Route path="/employers/:employer_id/earnings" exact component={AllEarnings} />
      <Route path="/employers/:employer_id/earnings/:id" exact component={Earning} />
    </Switch>
  </Router>
);