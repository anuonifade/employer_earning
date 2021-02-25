import React, { useState, useEffect } from 'react';
import {Link} from 'react-router-dom';
import AllEarnings from './AllEarnings';
import Api from '../api/Api';

const Employer = (props) => {
  const [employer, setEmployer] = useState({});

  useEffect(() => {
    (async () => {
      const response = await Api.fetchEmployer(props.match.params.id);
      if (response.status === 200) {
        setEmployer(response.data)
      }
    })();
  },[])

  return (
    <div className="vw-100 vh-100 primary-color d-flex mt-4 justify-content-center">
      <div className="jumbotron jumbotron-fluid bg-transparent">
        <div className="container secondary-color">
          <h4 className="display-4">Employer Details</h4>
          <table className="table my-4">
            <tbody>
              <tr>
                <th>Employer name</th>
                <td>{ employer && employer.name }</td>
              </tr>
              <tr>
                <th>Mapping Details</th>
                <td><pre>{ employer && JSON.stringify(employer.mapping) }</pre></td>
              </tr>
            </tbody>
          </table>
          <hr className="my-4" />
          <AllEarnings employerID={props.match.params.id} {...props} />
        </div>
      </div>
    </div>
  )
}

export default Employer