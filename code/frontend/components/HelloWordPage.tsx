import styles from "./HelloWordPage.module.css";
import { helloWordMock } from "../lib/mock/render-hello-word-page";

export function HelloWordPage() {
  return (
    <main aria-label="Hello Word page" className={styles.page}>
      <h1 className={styles.title}>{helloWordMock.displayText}</h1>
    </main>
  );
}
