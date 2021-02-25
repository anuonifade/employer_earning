import React from 'react';
import {
  Modal,
  ModalHeader,
  ModalBody,
  ModalFooter,
  Button,
  FormGroup,
  Label,
  Input,
  Form,
  InputGroup,
  InputGroupAddon,
} from 'reactstrap';

const AddEarnings = ({addEarningModal, closeAddModal}) => {

  return (
    <Modal isOpen={addEarningModal} >
      <ModalHeader charCode="Y" className="modal-header">Add Earnings</ModalHeader>
      <ModalBody>
        <Form>
          <FormGroup>
            <Label for="employeeRef">Employee Ref</Label>
            <Input type="text" name="employeeRef" id="employeeRef" placeholder="Employee Ref" />
          </FormGroup>
          <FormGroup>
            <Label for="examplePassword">Amount</Label>
            <InputGroup>
              <InputGroupAddon addonType="prepend">$</InputGroupAddon>
              <Input placeholder="Amount" min={0} max={200000} type="number" step="1" />
              <InputGroupAddon addonType="append">.00</InputGroupAddon>
            </InputGroup>
          </FormGroup>
        </Form>
      </ModalBody>
      <ModalFooter>
        <Button className="btn custom-button">Submit</Button>{' '}
        <Button color="secondary" onClick={closeAddModal}>Cancel</Button>
      </ModalFooter>
    </Modal>
  )
}

export default AddEarnings;
