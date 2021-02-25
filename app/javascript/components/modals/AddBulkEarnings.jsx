import React, {useState} from 'react';
import {
  Modal,
  ModalHeader,
  ModalBody,
  ModalFooter,
  Button,
  FormGroup,
  Label,
  Input,
  FormText
} from 'reactstrap';

const AddBulkEarnings = ({modal, closeModal, uploadFile, history, employerID}) => {
  const [file, setFile] = useState(null);
  const [error, setError] = useState(null);

  return (
    <Modal isOpen={modal} >
      <ModalHeader charCode="Y" className="modal-header">Upload bulk Earnings</ModalHeader>
      <ModalBody>
        {
          error && (
            <Alert color="danger">
              error
            </Alert>
          )
        }
        
        <FormGroup>
          <Label for="file">Upload Employer CSV Earning</Label>
          <Input type="file" name="file" id="earning-file" onChange= {(e) => {
            if (!e.target.files[0]) {
              setErrors("You did not select any file");
            } else {
              setError(null);
              setFile(e.target.files[0]);
            }
          }}/>
          <FormText color="muted">
            Ensure you upload a CSV and mapping is the same as Employer's Mapping.
          </FormText>
        </FormGroup>
      </ModalBody>
      <ModalFooter>
        <Button className="btn custom-button" onClick={ async () =>{
          if (file && !error) {
            const response = await uploadFile(employerID, file);
            console.log('RESPONSE >>>>>', response);
            if (response.status === 200 || response.status === 201) {
              closeModal;
              history.push(`/employers/${employerID}/earnings`);
            } else {
              setError(response.data.message);
            }
          }
        }}>Upload</Button>{' '}
        <Button color="secondary" onClick={closeModal}>Cancel</Button>
      </ModalFooter>
    </Modal>
  )
}

export default AddBulkEarnings;
