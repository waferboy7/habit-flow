import { render } from "@testing-library/vue";
import { Text } from "@/shared/ui";

test("Крутой текст", () => {
  const message = "test text";

  const { getByText } = render(Text, {
    props: { msg: message },
  });

  getByText(message);
});
