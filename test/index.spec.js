import chai, { expect } from "chai";
import chaiHttp from "chai-http";
import app from "../src/index";
chai.use(chaiHttp);

it("responds with status code 200", (done) => {
	chai
		.request(app)
		.get("/")
		.end((err, res) => {
			expect(err).to.be.null;
			expect(res).to.have.status(200);
			done();
		});
});
