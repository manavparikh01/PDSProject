import React, { useState } from 'react';
import Modal from 'react-modal';

const MyDialogBox = ({ isOpen, onClose, message }) => {
  return (
    <Modal
      isOpen={isOpen}
      onRequestClose={onClose}
      contentLabel="Example Modal"
    >
      <h2>{message}</h2>
      <button onClick={onClose}>Close</button>
    </Modal>
  );
};

export default MyDialogBox;
