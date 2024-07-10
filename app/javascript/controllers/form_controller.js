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
      <div class="modal" tabindex="-1" role="dialog" style="display: block; background-color: rgba(0, 0, 0, 0.5);">
        <div class="modal-dialog modal-dialog-centered" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title">Incomplete Form</h5>
            </div>
            <div class="modal-body">
              <p>Please fill up the rest of the form.</p>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary close-button" data-dismiss="modal">Close</button>
            </div>
          </div>
        </div>
      </div>
    `;

    const closeButton = this.popupTarget.querySelector('.close-button');
    closeButton.addEventListener('click', () => {
      this.closePopup();
    });
  }

  closePopup() {
    console.log("Closing popup");
    this.popupTarget.innerHTML = '';
  }
}
