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
  FormText,
  Alert
} from 'reactstrap';

const AddBulkEarnings = ({modal, closeModal, uploadFile, history, employerID}) => {
  const [file, setFile] = useState(null);
  const [error, setError] = useState(null);

  const upload = async() => {
    if (file && !error) {
      const response = await uploadFile(employerID, file);
      if (response.status === 200 || response.status === 201) {
        closeModal();
      } else {
        setError(response.data.message);
      }
    }
  };

  return (
    <Modal isOpen={modal} className="">
      <ModalHeader charCode="Y" className="modal-header">Upload bulk Earnings</ModalHeader>
      <ModalBody>
        {
          error && (
            <Alert color="danger">
              {error}
            </Alert>
          )
        }
        <FormGroup>
          <Label for="fileUpload">Upload Employer CSV Earning</Label>
          <Input type="file" name="file" id="earning-file" onChange= {(e) => {
            if (!e.target.files[0]) {
              setError("You did not select any file");
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
        <Button className="btn custom-button" onClick={ upload }>Upload</Button>{' '}
        <Button color="secondary" onClick={closeModal}>Cancel</Button>
      </ModalFooter>
    </Modal>
  )
}

export default AddBulkEarnings;
