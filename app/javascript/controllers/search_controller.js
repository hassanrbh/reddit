import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
    static targets = ["form"]

    connect() {
        console.log("connected to search");
    }

    make_debounce() {
        clearTimeout(this.timeout)
        this.timeout = setTimeout(() => {
            this.formTarget.requestSubmit();
        }, 500);
    }
}