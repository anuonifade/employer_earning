import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { Table } from 'reactstrap';
import Api from '../api/Api';

const AllEmployers = (props) => {
  const [employers, setEmployers] = useState([])

  useEffect(() => {
    (async () => {
      const response = await Api.fetchAllEmployers();
      if (response.status === 200) {
        setEmployers(response.data)
      }
    })();
  },[])

  return (
    <div className="vw-100 vh-100 primary-color d-flex mt-4 justify-content-center">
      <div className="jumbotron jumbotron-fluid bg-transparent">
        <div className="container secondary-color">
          <h4 className="display-4">Employers 
            <Link
              to="#"
              className="mx-2"
              role="button"
              onClick={() => {
                console.log('Adds')
              }}
              data-bs-toggle="tooltip"
              data-bs-placement="top"
              title="Add new Employer"
            >
              <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="currentColor" className="bi bi-plus-circle mx-1" viewBox="0 0 16 16">
                <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
                <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
              </svg>
            </Link>
          </h4>
          
          <Table className="table my-4" responsive hover>
            <thead>
              <tr>
                <th scope="col">#</th>
                <th scope="col">Employer name</th>
                <th scope="col">Mapping</th>
                <th scope="col">Actions</th>
              </tr>
            </thead>
            <tbody>
              {
                employers.map((emp, index) => (
                  <tr key={index}>
                    <th>
                      {index+1}
                    </th>
                    <td>
                      <Link
                        to={`/employers/${emp.id}`}
                        className=""
                        role="button"
                        data-bs-toggle="tooltip"
                        data-bs-placement="top"
                        title="View Employer details and Employees earnings"
                      >
                        { emp.name }
                      </Link>
                    </td>
                    <td>
                      { JSON.stringify(emp.mapping) }
                    </td>
                    <td>
                      
                      <Link
                        to="#"
                        className="mx-2"
                        role="button"
                        onClick={() => {
                          // Show the edit modal
                          console.log('VIEW');
                        }}
                        data-bs-toggle="tooltip"
                        data-bs-placement="top"
                        title="Edit Employer"
                      >
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="16" fill="currentColor" className="bi bi-vector-pen" viewBox="0 0 16 16">
                          <path fillRule="evenodd" d="M10.646.646a.5.5 0 0 1 .708 0l4 4a.5.5 0 0 1 0 .708l-1.902 1.902-.829 3.313a1.5 1.5 0 0 1-1.024 1.073L1.254 14.746 4.358 4.4A1.5 1.5 0 0 1 5.43 3.377l3.313-.828L10.646.646zm-1.8 2.908l-3.173.793a.5.5 0 0 0-.358.342l-2.57 8.565 8.567-2.57a.5.5 0 0 0 .34-.357l.794-3.174-3.6-3.6z"/>
                          <path fillRule="evenodd" d="M2.832 13.228L8 9a1 1 0 1 0-1-1l-4.228 5.168-.026.086.086-.026z"/>
                        </svg>
                      </Link>
                      <Link
                        to="#"
                        className="mx-2"
                        role="button"
                        onClick={() => {
                          // Verify before Delete
                          console.log('DELETE');
                        }}
                        data-bs-toggle="tooltip"
                        data-bs-placement="top"
                        title="Delete Employer"
                      >
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" className="bi bi-trash" viewBox="0 0 16 16">
                          <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
                          <path fillRule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4L4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"/>
                        </svg>
                      </Link>
                    </td>
                  </tr>
                ))
              }
            </tbody>
          </Table>
        </div>
      </div>
    </div>
  )
}

export default AllEmployers