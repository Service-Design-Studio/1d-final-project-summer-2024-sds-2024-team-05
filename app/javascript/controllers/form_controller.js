// app/javascript/controllers/form_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["popup"];

  connect() {
    console.log("FormController connected");
    this.validateForm();
  }

  validateForm() {
    console.log("validateForm called");
    const errorButtons = this.element.querySelectorAll(".btn-outline-red");
    if (errorButtons.length > 0) {
      console.log("Error buttons found");
      this.showPopup();
    }
  }

  showPopup() {
    console.log("Showing popup");
    this.popupTarget.innerHTML = `
      <div class="modal-backdrop" style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.5); z-index: 999;">
        <div class="popup" style="position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); background-color: white; padding: 20px; border: 1px solid red; z-index: 1000; border-radius: 1em;">
          <p style="text-align: center; color: black;">
            Please fill up the rest of the form
          </p>
          <button class="close-button" style="margin-top: 10px; display: block; margin: 0 auto; padding: 10px 20px; background-color: grey; color: white; border: none; border-radius: 1em; cursor: pointer;">
            Close
          </button>
        </div>
      </div>
    `;
    this.element.querySelector('.close-button').addEventListener('click', this.closePopup.bind(this));
  }

  closePopup() {
    console.log("Closing popup");
    this.popupTarget.innerHTML = '';
  }
}
